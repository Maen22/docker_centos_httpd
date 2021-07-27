node {
    def commit_id
    def client
    def server
    def to = 'to@example.com'
    try {
	stage('Preparation') {
            checkout scm
            sh 'git rev-parse --short HEAD > .git/commit-id'
            commit_id = readFile('.git/commit-id').trim()
        }

        stage('build/push server') {
            docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                docker.build("maen22/httpd-repo-server:${commit_id}", './server').push()
            }
        }

        stage('build/push client') {
            docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                docker.build("maen22/httpd-client:${commit_id}", './client').push()
            }
        }

        stage('run client/server'){
	    client = docker.image("maen22/httpd-client:${commit_id}").run("--tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name client")
            server = docker.image("maen22/httpd-repo-server:${commit_id}").run("--tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 8899:80")
        }

        stage('test images') {
            echo 'Testing...'
            def output = sh (
                            script: 'docker exec client ls -l /usr/sbin/httpd',
                            returnStdout: true
                        ).trim()
            echo "OUTPUT ----------------- $output ------------------"
            if (output == null || output.isEmpty()){
                error("httpd is not installed on the client!.")
            }

        }
    } catch(e) {
          currentBuild.result = "FAILURE";
          // set variables
          def subject = "${env.JOB_NAME} - Build #${env.BUILD_NUMBER} ${currentBuild.result}"
          def content = '${JELLY_SCRIPT,template="html"}'

          // send email
          if(to != null && !to.isEmpty()) {
            emailext(body: content, mimeType: 'text/html',
                replyTo: '$DEFAULT_REPLYTO', subject: subject,
                to: to, attachLog: true )
          }

          // mark current build as a failure and throw the error
          throw e;  
    } finally {
        client.stop()
        server.stop()  
      }
}
