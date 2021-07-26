node {
    def commit_id
    stage('Preparation') {
        checkout scm
        sh 'git rev-parse --short HEAD > .git/commit-id'
        commit_id = readFile('.git/commit-id').trim()
    }
    stage('test') {
        echo 'Testing...'
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
}
