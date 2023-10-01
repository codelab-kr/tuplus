node {
    def app

     stage('Clone repository') {
         checkout scm
     }

     stage('Update GIT') {
        script {
            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                withCredentials([usernamePassword(credentialsId: 'github_cred', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
                    sh "git config --global user.email master@code-lab.kr"
                    sh "git config --global user.name codelab-kr"
                    sh "if [[ -e './scripts/deploy/${SERVICE}.yaml' ]]; then cat ./scripts/deploy/${SERVICE}.yaml; else echo 'No file' fi"
                    // sh "cat ./scripts/deploy/${SERVICE}.yaml"
                    sh "sed -i 's+cnqphqevfxnp/${SERVICE}.*+cnqphqevfxnp/${SERVICE}:${DOCKERTAG}+g' ./scripts/deploy/${SERVICE}.yaml"
                    sh "cat ./scripts/deploy/${SERVICE}.yaml"
                    sh "git add ."
                    sh "git commit -m 'Done by Jenkins Job updatemaifest: ${SERVICE} to ${DOCKERTAG}'"
                    sh "git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/${GIT_USERNAME}/tuplus.git HEAD:feature"
                }
            }
        }
     }
}