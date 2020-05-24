pipeline {
    agent any
    stages {
        stage('Deps') {
            steps {
	            sh 'make deps'
        	}
        }
        stage('Lint') {
            steps {
	            sh 'make lint'
        	}
        }
        stage('Test') {
            steps {
	            sh 'make test_xunit || true'
	            xunit tresholds: [
	                skipped(failureTreshold: '0'),
	                failed(failureTreshold: '1')
	                ],
	                tools: [
	                    JUnit(deleteOutputFiles: true,
	                        failIfNotNew: true,
	                        pattern: 'test_results.xml',
	                        skipNoTestFiles: false,
	                        stopProcessingIfError: true)
	                ]
        	}
        }
    }
}