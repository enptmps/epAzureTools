describe 'DC-Test' {
    context 'Available' {
        it 'Excelsior is pingable' {
            (Test-Connection -ComputerName Excelsior -Count 1 -Quiet) | should be $true
        }
    }
    context 'Service Running' {
        it 'NTDS is running' {
            (Get-Service -ComputerName Excelsior -Name NTDS).Status | should be 'Running'
        }
    }
    context 'Best Practice' {
        it 'NTDS is o'
    }

}