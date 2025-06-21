(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1312 0)
(declare-sort var464 0)
(declare-sort var3259 0)
(declare-sort var1403 0)
(declare-sort var1395 0)
(declare-sort var523 0)
(declare-sort var367 0)
(declare-sort var3559 0)
(declare-sort var2958 0)
(declare-sort var1355 0)
(declare-sort var1235 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun children/-624348126 (var3259) var1403)
(declare-fun var1403_isEmpty/-153543822 (var1403) Bool)
(declare-fun var1395_length/1485543905 (String) Int)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun val$treeSB/-1943720399 (var1312) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun this$0/-1943720399 (var1312) var523)
(declare-fun var523_access$100/1960619880 (var523) Bool)
(declare-fun var367-init () var367)
(declare-fun var3559-init () var3559)
(declare-fun data/-624348126 (var3259) var2958)
(declare-fun toString/-522406933 (var2958) String)
(declare-fun <init>/814598262 (var3559 String) void)
(declare-fun <init>/-2021156853 (var367 var1355) void)
(declare-fun cast-from-var3559-to-var1355 (var3559) var1355)
(declare-fun addSuppressed/-2013977960 (var1235 var1235) void)
(declare-const null-var1312 var1312)
(declare-const null-Int Int)
(declare-const null-Bool Bool)
(declare-const null-String String)
(declare-const null-var3259 var3259)
(declare-const null-var1235 var1235)
(declare-const var2627 var1312) ; Statement: r2 := @this: org.apache.dubbo.qos.textui.TTree$1 
(assert (not (= var2627 null-var1312)))
(declare-const var3742 Int) ; Statement: i7 := @parameter0: int 
(assert (not (= var3742 null-Int)))
(declare-const var107 Bool) ; Statement: z2 := @parameter1: boolean 
(assert (not (= var107 null-Bool)))
(declare-const var1346 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var1346 null-String)))
(declare-const var3155 var3259) ; Statement: r0 := @parameter3: org.apache.dubbo.qos.textui.TTree$Node 
(assert (not (= var3155 null-var3259)))
(define-const var3126 var1403 (children/-624348126 var3155)) ; Statement: $r1 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.util.List children> 
(define-const var1357 Bool (var1403_isEmpty/-153543822 var3126)) ; Statement: $z0 = interfaceinvoke $r1.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z0 != 0 goto $z5 = 0 
(assert (not (not (= (ite var1357 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3504 Bool (ite (= 1 1) true false)) ; Statement: $z5 = 1 
 ; Statement: goto [?= z1 = $z5] 
(assert true) ; Non Conditional
(define-const var2464 Bool var3504) ; Statement: z1 = $z5 
 ; Statement: if z2 == 0 goto $r37 = "+---" 
(assert (= (ite var107 1 0) 0)) ; Cond: z2 == 0 
(define-const var3899 String "+---") ; Statement: $r37 = "+---" 
(define-const var1250 String "+---") ; Statement: $r36 = "+---" 
(assert true) ; Non Conditional
(define-const var548 Int (var1395_length/1485543905 (cast-from-String-to-String var3899))) ; Statement: $i6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>($r37) 
(define-const var861 String (val$treeSB/-1943720399 var2627)) ; Statement: $r4 = r2.<org.apache.dubbo.qos.textui.TTree$1: java.lang.StringBuilder val$treeSB> 
(assert true)
(define-const var283 String (append/672562846 var861 var1346)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var861!1 String)
(assert (= var861!1 (str.++ var861 var1346)))
(assert true)
;(assert (append/672562846 var283 var1250)) ; Statement: virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r36) 
(declare-const var283!1 String)
(assert (= var283!1 (str.++ var283 var1250)))
(define-const var2046 Int 0) ; Statement: i8 = 0 
 ; Statement: if z1 == 0 goto $r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0> 
(assert (= (ite var2464 1 0) 0)) ; Cond: z1 == 0 
(define-const var149 var523 (this$0/-1943720399 var2627)) ; Statement: $r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0> 
(define-const var1718 Bool (var523_access$100/1960619880 var149)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.qos.textui.TTree: boolean access$100(org.apache.dubbo.qos.textui.TTree)>($r6) 
 ; Statement: if $z3 == 0 goto $r31 = new java.util.Scanner 
(assert (= (ite var1718 1 0) 0)) ; Cond: $z3 == 0 
(define-const var3141 var367 var367-init) ; Statement: $r31 = new java.util.Scanner 
(define-const var1045 var3559 var3559-init) ; Statement: $r32 = new java.io.StringReader 
(define-const var1243 var2958 (data/-624348126 var3155)) ; Statement: $r33 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.lang.Object data> 
(assert true)
(define-const var2201 String (toString/-522406933 var1243)) ; Statement: $r34 = virtualinvoke $r33.<java.lang.Object: java.lang.String toString()>() 
(assert true)
;(assert (<init>/814598262 var1045 var2201)) ; Statement: specialinvoke $r32.<java.io.StringReader: void <init>(java.lang.String)>($r34) 

(declare-const var1045!1 var3559)
(declare-const var2201!1 String)
(assert true)
;(assert (<init>/-2021156853 var3141 (cast-from-var3559-to-var1355 var1045!1))) ; Statement: specialinvoke $r31.<java.util.Scanner: void <init>(java.lang.Readable)>($r32) 

(declare-const var3141!1 var367)
(declare-const var1045!2 var3559)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var381 var1235) ; Statement: $r28 := @caughtexception 
(assert (not (= var381 null-var1235)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3430 var1235) ; Statement: $r27 := @caughtexception 
(assert (not (= var3430 null-var1235)))
(assert true)
;(assert (addSuppressed/-2013977960 var381 var3430)) ; Statement: virtualinvoke $r28.<java.lang.Throwable: void addSuppressed(java.lang.Throwable)>($r27) 

(declare-const var381!1 var1235)
(declare-const var3430!1 var1235)
(assert true) ; Non Conditional
 ; Statement: throw $r28 
(check-sat)
; {children/-624348126=([org.apache.dubbo.qos.textui.TTree$Node], java.util.List), var1403_isEmpty/-153543822=([java.util.List], boolean), var1395_length/1485543905=([java.lang.CharSequence], int), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), val$treeSB/-1943720399=([org.apache.dubbo.qos.textui.TTree$1], java.lang.StringBuilder), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), this$0/-1943720399=([org.apache.dubbo.qos.textui.TTree$1], org.apache.dubbo.qos.textui.TTree), var523_access$100/1960619880=([org.apache.dubbo.qos.textui.TTree], boolean), var367-init=([], java.util.Scanner), var3559-init=([], java.io.StringReader), data/-624348126=([org.apache.dubbo.qos.textui.TTree$Node], java.lang.Object), toString/-522406933=([java.lang.Object], java.lang.String), <init>/814598262=([java.io.StringReader, java.lang.String], void), <init>/-2021156853=([java.util.Scanner, java.lang.Readable], void), cast-from-var3559-to-var1355=([java.io.StringReader], java.lang.Readable), addSuppressed/-2013977960=([java.lang.Throwable, java.lang.Throwable], void)}
; {var1312=org.apache.dubbo.qos.textui.TTree$1, var2627=r2, var3742=i7, var107=z2, var1346=r3, var464=null_type, var3259=org.apache.dubbo.qos.textui.TTree$Node, var3155=r0, var1403=java.util.List, var3126=$r1, var1357=$z0, var3504=$z5, var2464=z1, var3899=$r37, var1250=$r36, var1395=org.apache.dubbo.common.utils.StringUtils, var548=$i6, var861=$r4, var283=$r5, var2046=i8, var523=org.apache.dubbo.qos.textui.TTree, var149=$r6, var1718=$z3, var367=java.util.Scanner, var3141=$r31, var3559=java.io.StringReader, var1045=$r32, var2958=java.lang.Object, var1243=$r33, var2201=$r34, var1355=java.lang.Readable, var1235=java.lang.Throwable, var381=$r28, var3430=$r27}
; {org.apache.dubbo.qos.textui.TTree$1=var1312, r2=var2627, i7=var3742, z2=var107, r3=var1346, null_type=var464, org.apache.dubbo.qos.textui.TTree$Node=var3259, r0=var3155, java.util.List=var1403, $r1=var3126, $z0=var1357, $z5=var3504, z1=var2464, $r37=var3899, $r36=var1250, org.apache.dubbo.common.utils.StringUtils=var1395, $i6=var548, $r4=var861, $r5=var283, i8=var2046, org.apache.dubbo.qos.textui.TTree=var523, $r6=var149, $z3=var1718, java.util.Scanner=var367, $r31=var3141, java.io.StringReader=var3559, $r32=var1045, java.lang.Object=var2958, $r33=var1243, $r34=var2201, java.lang.Readable=var1355, java.lang.Throwable=var1235, $r28=var381, $r27=var3430}
;seq <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r2 := @this: org.apache.dubbo.qos.textui.TTree$1;	i7 := @parameter0: int;	z2 := @parameter1: boolean;	r3 := @parameter2: java.lang.String;	r0 := @parameter3: org.apache.dubbo.qos.textui.TTree$Node;	$r1 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.util.List children>;	$z0 = interfaceinvoke $r1.<java.util.List: boolean isEmpty()>();	if $z0 != 0 goto $z5 = 0;	$z5 = 1;	goto [?= z1 = $z5];	z1 = $z5;	if z2 == 0 goto $r37 = "+---";	$r37 = "+---";	$r36 = "+---";	$i6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>($r37);	$r4 = r2.<org.apache.dubbo.qos.textui.TTree$1: java.lang.StringBuilder val$treeSB>;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r36);	i8 = 0;	if z1 == 0 goto $r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0>;	$r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0>;	$z3 = staticinvoke <org.apache.dubbo.qos.textui.TTree: boolean access$100(org.apache.dubbo.qos.textui.TTree)>($r6);	if $z3 == 0 goto $r31 = new java.util.Scanner;	$r31 = new java.util.Scanner;	$r32 = new java.io.StringReader;	$r33 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.lang.Object data>;	$r34 = virtualinvoke $r33.<java.lang.Object: java.lang.String toString()>();	specialinvoke $r32.<java.io.StringReader: void <init>(java.lang.String)>($r34);	specialinvoke $r31.<java.util.Scanner: void <init>(java.lang.Readable)>($r32);	$r28 := @caughtexception;	$r27 := @caughtexception;	virtualinvoke $r28.<java.lang.Throwable: void addSuppressed(java.lang.Throwable)>($r27);	throw $r28
;block_num 10