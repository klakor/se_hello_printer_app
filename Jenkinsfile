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
	            xunit thresholds: [
	                failed(unstableThreshold: '1'),
	                skipped(unstableThreshold: '0')
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