Rem %1 - first input PDF-file
Rem %2 - second input PDF-file
Rem %3 - number of first page in first document to be replaced
Rem %4 - number of first page in second document to be replacement
Rem %5 - amount of pages to replace
Rem %6 - 1 if needed to resume copy from the first document
Rem %7 - output file (optional)

set copy_page_parameter=cat

Rem pages being copied from the first document (if not first page need to be replaced)
set /a "last_page_before_replace=%3-1"
if %last_page_before_replace% gtr 0 (
	set copy_page_parameter=%copy_page_parameter% A1
)
if %last_page_before_replace% gtr 1 (
	set copy_page_parameter=%copy_page_parameter%-%last_page_before_replace%
)

set copy_page_parameter=%copy_page_parameter% B%4
if %5 gtr 1 (
	set /a "last_replacement_page=%4+%5-1"
	set copy_page_parameter=%copy_page_parameter%-%last_replacement_page%
)

if [%6] == [1] (
	set /a "resume_document_a_first_page=%3+%5"
	set copy_page_parameter=%copy_page_parameter% A%resume_document_a_first_page%-end
)

set output_file=%~n1_out.pdf
if not [%7] == [] (
	set output_file=%7
)

pdftk A=%1 B=%2 %copy_page_parameter% output %output_file%
