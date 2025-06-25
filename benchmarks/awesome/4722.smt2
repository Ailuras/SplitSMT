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

(declare-sort var2567 0)
(declare-sort var1517 0)
(declare-sort var2102 0)
(declare-sort var635 0)
(declare-sort var1371 0)
(declare-sort var3258 0)
(declare-sort var2183 0)
(declare-sort var2389 0)
(declare-sort var143 0)
(declare-sort var3390 0)
(declare-sort var1250 0)
(declare-sort var1268 0)
(declare-sort var2630 0)
(declare-sort var360 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1371) void)
(declare-fun cast-from-var2567-to-var1371 (var2567) var1371)
(declare-fun _filesystem/-104202844 (var2567) var2102)
(declare-fun var3258-init () var3258)
(declare-fun getMiniStore/-1016087800 (var2102) var2183)
(declare-fun <init>/-1297741524 (var3258 var2389) void)
(declare-fun cast-from-var2183-to-var2389 (var2183) var2389)
(declare-fun _stream/-104202844 (var2567) var3258)
(declare-fun getBlockStoreBlockSize/2135242053 (var2183) Int)
(declare-fun _block_size/-104202844 (var2567) Int)
(declare-fun getOutputStream/-351679274 (var3258) var143)
(declare-fun var3390-init () var3390)
(declare-fun <init>/178425861 (var3390 var143 Int) void)
(declare-fun var1250-init () var1250)
(declare-fun <init>/1339707007 (var1250 (Array Int String)) void)
(declare-fun length/397627981 (var1250) Int)
(declare-fun getComponent/786014245 (var1250 Int) String)
(declare-fun var1268-init () var1268)
(declare-fun <init>/1216773118 (var1268 var3390 var1250 String Int) void)
(declare-fun var635_processPOIFSWriterEvent/-1220698864 (var635 var1268) void)
(declare-fun close/1295285938 (var143) void)
(declare-fun var2630-init () var2630)
(declare-fun <init>/-539943113 (var2630 String Int) void)
(declare-fun _property/-104202844 (var2567) var2630)
(declare-fun getStartBlock/-1725674112 (var3258) Int)
(declare-fun setStartBlock/-1955402574 (var360 Int) void)
(declare-fun cast-from-var2630-to-var360 (var2630) var360)
(declare-const null-var2567 var2567)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-var2102 var2102)
(declare-const null-var635 var635)
(declare-const var1389 var2567) ; Statement: r0 := @this: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument 
(assert (not (= var1389 null-var2567)))
(declare-const var2841 String) ; Statement: r7 := @parameter0: java.lang.String 
(assert (not (= var2841 null-String)))
(declare-const var3593 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var3593 null-Int)))
(declare-const var1879 var2102) ; Statement: r1 := @parameter2: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem 
(assert (not (= var1879 null-var2102)))
(declare-const var3578 var635) ; Statement: r10 := @parameter3: org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener 
(assert (not (= var3578 null-var635)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2567-to-var1371 var1389))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var1389!1 var2567)
(declare-const var1389!2 var2567)
(assert (not (= var1389!2 null-var2567)))
(assert (= (_filesystem/-104202844 var1389!2) var1879)) ; Statement: r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem _filesystem> = r1 
 ; Statement: if i0 >= 4096 goto $r2 = new org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream 
(assert (not (>= var3593 4096))) ; Negate: Cond: i0 >= 4096  
(define-const var1587 var3258 var3258-init) ; Statement: $r14 = new org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream 
(assert true)
(define-const var2382 var2183 (getMiniStore/-1016087800 var1879)) ; Statement: $r15 = virtualinvoke r1.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSMiniStore getMiniStore()>() 
(assert true)
;(assert (<init>/-1297741524 var1587 (cast-from-var2183-to-var2389 var2382))) ; Statement: specialinvoke $r14.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream: void <init>(org.docx4j.org.apache.poi.poifs.filesystem.BlockStore)>($r15) 

(declare-const var1587!1 var3258)
(declare-const var2382!1 var2183)
(declare-const var1389!3 var2567)
(assert (not (= var1389!3 null-var2567)))
(assert (= (_stream/-104202844 var1389!3) var1587!1)) ; Statement: r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream> = $r14 
(define-const var1267 var2102 (_filesystem/-104202844 var1389!3)) ; Statement: $r16 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem _filesystem> 
(assert true)
(define-const var1343 var2183 (getMiniStore/-1016087800 var1267)) ; Statement: $r17 = virtualinvoke $r16.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSMiniStore getMiniStore()>() 
(assert true)
(define-const var1172 Int (getBlockStoreBlockSize/2135242053 var1343)) ; Statement: $i5 = virtualinvoke $r17.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSMiniStore: int getBlockStoreBlockSize()>() 
(declare-const var1389!4 var2567)
(assert (not (= var1389!4 null-var2567)))
(assert (= (_block_size/-104202844 var1389!4) var1172)) ; Statement: r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: int _block_size> = $i5 
 ; Statement: goto [?= $r4 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream>] 
(assert true) ; Non Conditional
(define-const var255 var3258 (_stream/-104202844 var1389!4)) ; Statement: $r4 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream> 
(assert true)
(define-const var3343 var143 (getOutputStream/-351679274 var255)) ; Statement: $r18 = virtualinvoke $r4.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream: java.io.OutputStream getOutputStream()>() 
(define-const var1720 var3390 var3390-init) ; Statement: $r5 = new org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream 
(assert true)
;(assert (<init>/178425861 var1720 var3343 var3593)) ; Statement: specialinvoke $r5.<org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream: void <init>(java.io.OutputStream,int)>($r18, i0) 

(declare-const var1720!1 var3390)
(declare-const var3343!1 var143)
(declare-const var3593!1 Int)
(define-const var2599 var1250 var1250-init) ; Statement: $r6 = new org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath 
; split operation: var2532 = var2841.split("\u005c\u005c") ; Statement: $r8 = virtualinvoke r7.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\\\") 
(assert true)
;(assert (<init>/1339707007 var2599 var2532)) ; Statement: specialinvoke $r6.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath: void <init>(java.lang.String[])>($r8) 

(declare-const var2599!1 var1250)
(declare-const var2532!1 (Array Int String))
(assert true)
(define-const var3518 Int (length/397627981 var2599!1)) ; Statement: $i2 = virtualinvoke $r6.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath: int length()>() 
(define-const var1482 Int (- var3518 1)) ; Statement: $i3 = $i2 - 1 
(assert true)
(define-const var3550 String (getComponent/786014245 var2599!1 var1482)) ; Statement: $r19 = virtualinvoke $r6.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath: java.lang.String getComponent(int)>($i3) 
(define-const var3006 var1268 var1268-init) ; Statement: $r9 = new org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent 
(assert true)
;(assert (<init>/1216773118 var3006 var1720!1 var2599!1 var3550 var3593!1)) ; Statement: specialinvoke $r9.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent: void <init>(org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream,org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath,java.lang.String,int)>($r5, $r6, $r19, i0) 

(declare-const var3006!1 var1268)
(declare-const var1720!2 var3390)
(declare-const var2599!2 var1250)
(declare-const var3550!1 String)
(declare-const var3593!2 Int)
;(assert (var635_processPOIFSWriterEvent/-1220698864 var3578 var3006!1)) ; Statement: interfaceinvoke r10.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener: void processPOIFSWriterEvent(org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent)>($r9) 

(declare-const var3578!1 var635)
(declare-const var3006!2 var1268)
(assert true)
;(assert (close/1295285938 var3343!1)) ; Statement: virtualinvoke $r18.<java.io.OutputStream: void close()>() 

(declare-const var3343!2 var143)
(define-const var1513 var2630 var2630-init) ; Statement: $r11 = new org.docx4j.org.apache.poi.poifs.property.DocumentProperty 
(assert true)
;(assert (<init>/-539943113 var1513 var2841 var3593!2)) ; Statement: specialinvoke $r11.<org.docx4j.org.apache.poi.poifs.property.DocumentProperty: void <init>(java.lang.String,int)>(r7, i0) 

(declare-const var1513!1 var2630)
(declare-const var2841!1 String)
(declare-const var3593!3 Int)
(declare-const var1389!5 var2567)
(assert (not (= var1389!5 null-var2567)))
(assert (= (_property/-104202844 var1389!5) var1513!1)) ; Statement: r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.property.DocumentProperty _property> = $r11 
(define-const var3828 var2630 (_property/-104202844 var1389!5)) ; Statement: $r13 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.property.DocumentProperty _property> 
(define-const var741 var3258 (_stream/-104202844 var1389!5)) ; Statement: $r12 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream> 
(assert true)
(define-const var1334 Int (getStartBlock/-1725674112 var741)) ; Statement: $i4 = virtualinvoke $r12.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream: int getStartBlock()>() 
(assert true)
;(assert (setStartBlock/-1955402574 (cast-from-var2630-to-var360 var3828) var1334)) ; Statement: virtualinvoke $r13.<org.docx4j.org.apache.poi.poifs.property.DocumentProperty: void setStartBlock(int)>($i4) 

(declare-const var3828!1 var2630)
(declare-const var1334!1 Int)
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2567-to-var1371=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument], java.lang.Object), _filesystem/-104202844=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument], org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem), var3258-init=([], org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream), getMiniStore/-1016087800=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem], org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSMiniStore), <init>/-1297741524=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream, org.docx4j.org.apache.poi.poifs.filesystem.BlockStore], void), cast-from-var2183-to-var2389=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSMiniStore], org.docx4j.org.apache.poi.poifs.filesystem.BlockStore), _stream/-104202844=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument], org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream), getBlockStoreBlockSize/2135242053=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSMiniStore], int), _block_size/-104202844=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument], int), getOutputStream/-351679274=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream], java.io.OutputStream), var3390-init=([], org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream), <init>/178425861=([org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream, java.io.OutputStream, int], void), var1250-init=([], org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath), <init>/1339707007=([org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath, java.lang.String[]], void), length/397627981=([org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath], int), getComponent/786014245=([org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath, int], java.lang.String), var1268-init=([], org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent), <init>/1216773118=([org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent, org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream, org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath, java.lang.String, int], void), var635_processPOIFSWriterEvent/-1220698864=([org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener, org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent], void), close/1295285938=([java.io.OutputStream], void), var2630-init=([], org.docx4j.org.apache.poi.poifs.property.DocumentProperty), <init>/-539943113=([org.docx4j.org.apache.poi.poifs.property.DocumentProperty, java.lang.String, int], void), _property/-104202844=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument], org.docx4j.org.apache.poi.poifs.property.DocumentProperty), getStartBlock/-1725674112=([org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream], int), setStartBlock/-1955402574=([org.docx4j.org.apache.poi.poifs.property.Property, int], void), cast-from-var2630-to-var360=([org.docx4j.org.apache.poi.poifs.property.DocumentProperty], org.docx4j.org.apache.poi.poifs.property.Property)}
; {var2567=org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument, var1389=r0, var2841=r7, var1517=null_type, var3593=i0, var2102=org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem, var1879=r1, var635=org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener, var3578=r10, var1371=java.lang.Object, var3258=org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream, var1587=$r14, var2183=org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSMiniStore, var2382=$r15, var2389=org.docx4j.org.apache.poi.poifs.filesystem.BlockStore, var1267=$r16, var1343=$r17, var1172=$i5, var255=$r4, var143=java.io.OutputStream, var3343=$r18, var3390=org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream, var1720=$r5, var1250=org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath, var2599=$r6, var2532=$r8, var3518=$i2, var1482=$i3, var3550=$r19, var1268=org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent, var3006=$r9, var2630=org.docx4j.org.apache.poi.poifs.property.DocumentProperty, var1513=$r11, var3828=$r13, var741=$r12, var1334=$i4, var360=org.docx4j.org.apache.poi.poifs.property.Property}
; {org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument=var2567, r0=var1389, r7=var2841, null_type=var1517, i0=var3593, org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem=var2102, r1=var1879, org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener=var635, r10=var3578, java.lang.Object=var1371, org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream=var3258, $r14=var1587, org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSMiniStore=var2183, $r15=var2382, org.docx4j.org.apache.poi.poifs.filesystem.BlockStore=var2389, $r16=var1267, $r17=var1343, $i5=var1172, $r4=var255, java.io.OutputStream=var143, $r18=var3343, org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream=var3390, $r5=var1720, org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath=var1250, $r6=var2599, $r8=var2532, $i2=var3518, $i3=var1482, $r19=var3550, org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent=var1268, $r9=var3006, org.docx4j.org.apache.poi.poifs.property.DocumentProperty=var2630, $r11=var1513, $r13=var3828, $r12=var741, $i4=var1334, org.docx4j.org.apache.poi.poifs.property.Property=var360}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument;	r7 := @parameter0: java.lang.String;	i0 := @parameter1: int;	r1 := @parameter2: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem;	r10 := @parameter3: org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem _filesystem> = r1;	if i0 >= 4096 goto $r2 = new org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream;	$r14 = new org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream;	$r15 = virtualinvoke r1.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSMiniStore getMiniStore()>();	specialinvoke $r14.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream: void <init>(org.docx4j.org.apache.poi.poifs.filesystem.BlockStore)>($r15);	r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream> = $r14;	$r16 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem _filesystem>;	$r17 = virtualinvoke $r16.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSFileSystem: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSMiniStore getMiniStore()>();	$i5 = virtualinvoke $r17.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSMiniStore: int getBlockStoreBlockSize()>();	r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: int _block_size> = $i5;	goto [?= $r4 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream>];	$r4 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream>;	$r18 = virtualinvoke $r4.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream: java.io.OutputStream getOutputStream()>();	$r5 = new org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream;	specialinvoke $r5.<org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream: void <init>(java.io.OutputStream,int)>($r18, i0);	$r6 = new org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath;	$r8 = virtualinvoke r7.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\\\");	specialinvoke $r6.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath: void <init>(java.lang.String[])>($r8);	$i2 = virtualinvoke $r6.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath: int length()>();	$i3 = $i2 - 1;	$r19 = virtualinvoke $r6.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath: java.lang.String getComponent(int)>($i3);	$r9 = new org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent;	specialinvoke $r9.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent: void <init>(org.docx4j.org.apache.poi.poifs.filesystem.DocumentOutputStream,org.docx4j.org.apache.poi.poifs.filesystem.POIFSDocumentPath,java.lang.String,int)>($r5, $r6, $r19, i0);	interfaceinvoke r10.<org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener: void processPOIFSWriterEvent(org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterEvent)>($r9);	virtualinvoke $r18.<java.io.OutputStream: void close()>();	$r11 = new org.docx4j.org.apache.poi.poifs.property.DocumentProperty;	specialinvoke $r11.<org.docx4j.org.apache.poi.poifs.property.DocumentProperty: void <init>(java.lang.String,int)>(r7, i0);	r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.property.DocumentProperty _property> = $r11;	$r13 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.property.DocumentProperty _property>;	$r12 = r0.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSDocument: org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream _stream>;	$i4 = virtualinvoke $r12.<org.docx4j.org.apache.poi.poifs.filesystem.NPOIFSStream: int getStartBlock()>();	virtualinvoke $r13.<org.docx4j.org.apache.poi.poifs.property.DocumentProperty: void setStartBlock(int)>($i4);	return
;block_num 3