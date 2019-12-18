Rem Save Bookmarks
pdftk 1.pdf dump_data > in.info

Rem Restore Bookmarks
pdftk out.pdf update_info in.info output out2.pdf 
