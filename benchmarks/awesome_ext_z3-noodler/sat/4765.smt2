(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2590 0)
(declare-sort var675 0)
(declare-sort var1014 0)
(declare-sort var3903 0)
(declare-sort var3974 0)
(declare-sort var3929 0)
(declare-sort var2250 0)
(declare-sort var665 0)
(declare-sort var36 0)
(declare-sort var1879 0)
(declare-sort var1055 0)
(declare-sort var2831 0)
(declare-sort var1826 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var3974) void)
(declare-fun cast-from-var2590-to-var3974 (var2590) var3974)
(declare-fun _filesystem/-104202844 (var2590) var1014)
(declare-fun var3929-init () var3929)
(declare-fun <init>/-1297741524 (var3929 var2250) void)
(declare-fun cast-from-var1014-to-var2250 (var1014) var2250)
(declare-fun _stream/-104202844 (var2590) var3929)
(declare-fun getBlockStoreBlockSize/272622378 (var1014) Int)
(declare-fun _block_size/-104202844 (var2590) Int)
(declare-fun getOutputStream/-351679274 (var3929) var665)
(declare-fun var36-init () var36)
(declare-fun <init>/178425861 (var36 var665 Int) void)
(declare-fun var1879-init () var1879)
(declare-fun <init>/1339707007 (var1879 (Array Int String)) void)
(declare-fun length/397627981 (var1879) Int)
(declare-fun getComponent/786014245 (var1879 Int) String)
(declare-fun var1055-init () var1055)
(declare-fun <init>/1216773118 (var1055 var36 var1879 String Int) void)
(declare-fun var3903_processPOIFSWriterEvent/-1220698864 (var3903 var1055) void)
(declare-fun close/1295285938 (var665) void)
(declare-fun var2831-init () var2831)
(declare-fun <init>/-539943113 (var2831 String Int) void)
(declare-fun _property/-104202844 (var2590) var2831)
(declare-fun getStartBlock/-1725674112 (var3929) Int)
(declare-fun setStartBlock/-1955402574 (var1826 Int) void)
(declare-fun cast-from-var2831-to-var1826 (var2831) var1826)
(declare-const null-var2590 var2590)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-var1014 var1014)
(declare-const null-var3903 var3903)
(declare-const var77 var2590) ; Statement: r0 := @this: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument 
(assert (not (= var77 null-var2590)))
(declare-const var1659 String) ; Statement: r7 := @parameter0: java.lang.String 
(assert (not (= var1659 null-String)))
(declare-const var373 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var373 null-Int)))
(declare-const var1737 var1014) ; Statement: r1 := @parameter2: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem 
(assert (not (= var1737 null-var1014)))
(declare-const var783 var3903) ; Statement: r10 := @parameter3: org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener 
(assert (not (= var783 null-var3903)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2590-to-var3974 var77))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var77!1 var2590)
(declare-const var77!2 var2590)
(assert (not (= var77!2 null-var2590)))
(assert (= (_filesystem/-104202844 var77!2) var1737)) ; Statement: r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem _filesystem> = r1 
 ; Statement: if i0 >= 4096 goto $r2 = new org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream 
(assert (>= var373 4096)) ; Cond: i0 >= 4096 
(define-const var1164 var3929 var3929-init) ; Statement: $r2 = new org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream 
(assert true)
;(assert (<init>/-1297741524 var1164 (cast-from-var1014-to-var2250 var1737))) ; Statement: specialinvoke $r2.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream: void <init>(org.docx4j.org.apache.poi.poifs.filesystem.BlockStore)>(r1) 

(declare-const var1164!1 var3929)
(declare-const var1737!1 var1014)
(declare-const var77!3 var2590)
(assert (not (= var77!3 null-var2590)))
(assert (= (_stream/-104202844 var77!3) var1164!1)) ; Statement: r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream> = $r2 
(define-const var677 var1014 (_filesystem/-104202844 var77!3)) ; Statement: $r3 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem _filesystem> 
(assert true)
(define-const var1109 Int (getBlockStoreBlockSize/272622378 var677)) ; Statement: $i1 = virtualinvoke $r3.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem: int getBlockStoreBlockSize()>() 
(declare-const var77!4 var2590)
(assert (not (= var77!4 null-var2590)))
(assert (= (_block_size/-104202844 var77!4) var1109)) ; Statement: r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: int _block_size> = $i1 
(assert true) ; Non Conditional
(define-const var469 var3929 (_stream/-104202844 var77!4)) ; Statement: $r4 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream> 
(assert true)
(define-const var2979 var665 (getOutputStream/-351679274 var469)) ; Statement: $r18 = virtualinvoke $r4.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream: java.io.OutputStream getOutputStream()>() 
(define-const var1340 var36 var36-init) ; Statement: $r5 = new org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream 
(assert true)
;(assert (<init>/178425861 var1340 var2979 var373)) ; Statement: specialinvoke $r5.<org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream: void <init>(java.io.OutputStream,int)>($r18, i0) 

(declare-const var1340!1 var36)
(declare-const var2979!1 var665)
(declare-const var373!1 Int)
(define-const var2314 var1879 var1879-init) ; Statement: $r6 = new org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath 
; split operation: var197 = var1659.split("\u005c\u005c") ; Statement: $r8 = virtualinvoke r7.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\\\") 
(assert true)
;(assert (<init>/1339707007 var2314 var197)) ; Statement: specialinvoke $r6.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath: void <init>(java.lang.String[])>($r8) 

(declare-const var2314!1 var1879)
(declare-const var197!1 (Array Int String))
(assert true)
(define-const var3146 Int (length/397627981 var2314!1)) ; Statement: $i2 = virtualinvoke $r6.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath: int length()>() 
(define-const var848 Int (- var3146 1)) ; Statement: $i3 = $i2 - 1 
(assert true)
(define-const var2286 String (getComponent/786014245 var2314!1 var848)) ; Statement: $r19 = virtualinvoke $r6.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath: java.lang.String getComponent(int)>($i3) 
(define-const var966 var1055 var1055-init) ; Statement: $r9 = new org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent 
(assert true)
;(assert (<init>/1216773118 var966 var1340!1 var2314!1 var2286 var373!1)) ; Statement: specialinvoke $r9.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent: void <init>(org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream,org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath,java.lang.String,int)>($r5, $r6, $r19, i0) 

(declare-const var966!1 var1055)
(declare-const var1340!2 var36)
(declare-const var2314!2 var1879)
(declare-const var2286!1 String)
(declare-const var373!2 Int)
;(assert (var3903_processPOIFSWriterEvent/-1220698864 var783 var966!1)) ; Statement: interfaceinvoke r10.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener: void processPOIFSWriterEvent(org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent)>($r9) 

(declare-const var783!1 var3903)
(declare-const var966!2 var1055)
(assert true)
;(assert (close/1295285938 var2979!1)) ; Statement: virtualinvoke $r18.<java.io.OutputStream: void close()>() 

(declare-const var2979!2 var665)
(define-const var992 var2831 var2831-init) ; Statement: $r11 = new org.docx4j.org.apache.poi.poifs.property.DocumentProperty 
(assert true)
;(assert (<init>/-539943113 var992 var1659 var373!2)) ; Statement: specialinvoke $r11.<org.docx4j.org.apache.poi.poifs.property.DocumentProperty: void <init>(java.lang.String,int)>(r7, i0) 

(declare-const var992!1 var2831)
(declare-const var1659!1 String)
(declare-const var373!3 Int)
(declare-const var77!5 var2590)
(assert (not (= var77!5 null-var2590)))
(assert (= (_property/-104202844 var77!5) var992!1)) ; Statement: r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.property.DocumentProperty _property> = $r11 
(define-const var2374 var2831 (_property/-104202844 var77!5)) ; Statement: $r13 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.property.DocumentProperty _property> 
(define-const var375 var3929 (_stream/-104202844 var77!5)) ; Statement: $r12 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream> 
(assert true)
(define-const var3801 Int (getStartBlock/-1725674112 var375)) ; Statement: $i4 = virtualinvoke $r12.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream: int getStartBlock()>() 
(assert true)
;(assert (setStartBlock/-1955402574 (cast-from-var2831-to-var1826 var2374) var3801)) ; Statement: virtualinvoke $r13.<org.docx4j.org.apache.poi.poifs.property.DocumentProperty: void setStartBlock(int)>($i4) 

(declare-const var2374!1 var2831)
(declare-const var3801!1 Int)
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2590-to-var3974=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument], java.lang.Object), _filesystem/-104202844=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument], org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem), var3929-init=([], org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream), <init>/-1297741524=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream, org.docx4j.org.apache.poi.poifs.filesystem.BlockStore], void), cast-from-var1014-to-var2250=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem], org.docx4j.org.apache.poi.poifs.filesystem.BlockStore), _stream/-104202844=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument], org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream), getBlockStoreBlockSize/272622378=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem], int), _block_size/-104202844=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument], int), getOutputStream/-351679274=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream], java.io.OutputStream), var36-init=([], org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream), <init>/178425861=([org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream, java.io.OutputStream, int], void), var1879-init=([], org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath), <init>/1339707007=([org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath, java.lang.String[]], void), length/397627981=([org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath], int), getComponent/786014245=([org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath, int], java.lang.String), var1055-init=([], org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent), <init>/1216773118=([org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent, org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream, org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath, java.lang.String, int], void), var3903_processPOIFSWriterEvent/-1220698864=([org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener, org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent], void), close/1295285938=([java.io.OutputStream], void), var2831-init=([], org.docx4j.org.apache.poi.poifs.property.DocumentProperty), <init>/-539943113=([org.docx4j.org.apache.poi.poifs.property.DocumentProperty, java.lang.String, int], void), _property/-104202844=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument], org.docx4j.org.apache.poi.poifs.property.DocumentProperty), getStartBlock/-1725674112=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream], int), setStartBlock/-1955402574=([org.docx4j.org.apache.poi.poifs.property.Property, int], void), cast-from-var2831-to-var1826=([org.docx4j.org.apache.poi.poifs.property.DocumentProperty], org.docx4j.org.apache.poi.poifs.property.Property)}
; {var2590=org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument, var77=r0, var1659=r7, var675=null_type, var373=i0, var1014=org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem, var1737=r1, var3903=org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener, var783=r10, var3974=java.lang.Object, var3929=org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream, var1164=$r2, var2250=org.docx4j.org.apache.poi.poifs.filesystem.BlockStore, var677=$r3, var1109=$i1, var469=$r4, var665=java.io.OutputStream, var2979=$r18, var36=org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream, var1340=$r5, var1879=org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath, var2314=$r6, var197=$r8, var3146=$i2, var848=$i3, var2286=$r19, var1055=org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent, var966=$r9, var2831=org.docx4j.org.apache.poi.poifs.property.DocumentProperty, var992=$r11, var2374=$r13, var375=$r12, var3801=$i4, var1826=org.docx4j.org.apache.poi.poifs.property.Property}
; {org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument=var2590, r0=var77, r7=var1659, null_type=var675, i0=var373, org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem=var1014, r1=var1737, org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener=var3903, r10=var783, java.lang.Object=var3974, org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream=var3929, $r2=var1164, org.docx4j.org.apache.poi.poifs.filesystem.BlockStore=var2250, $r3=var677, $i1=var1109, $r4=var469, java.io.OutputStream=var665, $r18=var2979, org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream=var36, $r5=var1340, org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath=var1879, $r6=var2314, $r8=var197, $i2=var3146, $i3=var848, $r19=var2286, org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent=var1055, $r9=var966, org.docx4j.org.apache.poi.poifs.property.DocumentProperty=var2831, $r11=var992, $r13=var2374, $r12=var375, $i4=var3801, org.docx4j.org.apache.poi.poifs.property.Property=var1826}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument;	r7 := @parameter0: java.lang.String;	i0 := @parameter1: int;	r1 := @parameter2: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem;	r10 := @parameter3: org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem _filesystem> = r1;	if i0 >= 4096 goto $r2 = new org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream;	$r2 = new org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream;	specialinvoke $r2.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream: void <init>(org.docx4j.org.apache.poi.poifs.filesystem.BlockStore)>(r1);	r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream> = $r2;	$r3 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem _filesystem>;	$i1 = virtualinvoke $r3.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem: int getBlockStoreBlockSize()>();	r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: int _block_size> = $i1;	$r4 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream>;	$r18 = virtualinvoke $r4.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream: java.io.OutputStream getOutputStream()>();	$r5 = new org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream;	specialinvoke $r5.<org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream: void <init>(java.io.OutputStream,int)>($r18, i0);	$r6 = new org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath;	$r8 = virtualinvoke r7.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\\\");	specialinvoke $r6.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath: void <init>(java.lang.String[])>($r8);	$i2 = virtualinvoke $r6.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath: int length()>();	$i3 = $i2 - 1;	$r19 = virtualinvoke $r6.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath: java.lang.String getComponent(int)>($i3);	$r9 = new org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent;	specialinvoke $r9.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent: void <init>(org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream,org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath,java.lang.String,int)>($r5, $r6, $r19, i0);	interfaceinvoke r10.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener: void processPOIFSWriterEvent(org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent)>($r9);	virtualinvoke $r18.<java.io.OutputStream: void close()>();	$r11 = new org.docx4j.org.apache.poi.poifs.property.DocumentProperty;	specialinvoke $r11.<org.docx4j.org.apache.poi.poifs.property.DocumentProperty: void <init>(java.lang.String,int)>(r7, i0);	r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.property.DocumentProperty _property> = $r11;	$r13 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.property.DocumentProperty _property>;	$r12 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream>;	$i4 = virtualinvoke $r12.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream: int getStartBlock()>();	virtualinvoke $r13.<org.docx4j.org.apache.poi.poifs.property.DocumentProperty: void setStartBlock(int)>($i4);	return
;block_num 3