#1.	Вывести список событий-ошибок из системного лога, за последнюю неделю. Результат представить в виде файла XML.

$a = Get-Date 
Get-EventLog -LogName System -EntryType Error | Where-Object {$_.TimeGenerated -gt $a.AddDays(-7)} | Export-Clixml C:\M2T2_KALLAUR\Err.xml


#2.	Вывести список файлов *.log хранящихся в папке C:\Windows. Вывод организовать в виде таблицы с обратной сортировкой по имени файла, при этом выводить полное имя файла, размер файла, время создания. 

dir C:\Windows -Filter *.log | Sort-Object Name -Descending | Select-Object Name, Length, LastWriteTime

#3.	Создать файл-сценарий вывода всех чисел делящихся без остатка на 3, на интервале от А до В, где А и В — входные параметры, параметр А по умолчанию равен 0, параметр В обязателен для ввода.

[CmdletBinding()]
Param (
    [int]$A = 0,
    [parameter(Mandatory=$true, HelpMessage="Enter: B")]
    [int]$B 
)
$arr = @($A..$B)
foreach ($i in $arr) {
    if (!($i%3)) {
       Write-Output($i) 
    }
}

#4.	Проверить на удалённых компьютерах состояние одной службы (имя определить самостоятельно). Перечень имен компьютеров должен браться из текстового файла. Вывод организовать следующим образом: Имя компьютера – статус (если служба запущена, то строка зелёная, иначе красная)
#Доступ есть только к VM2, поэтому в файле прописываю только VM2.Ход решения задачи, но оно не выполнено! Пока не выходит, но я буду разбираться.
$a = Get-Content C:\M2T2_KALLAUR\hosts.txt
$b = Get-WmiObject Win32_Service -Credential Administrator -ComputerName $a
foreach ($i in $b) {
    $i = Select-Object -Unique Spooler 
}
Write-Host -ForegroundColor Green $i 

