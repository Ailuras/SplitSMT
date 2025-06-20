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

(declare-sort var1459 0)
(declare-sort var552 0)
(declare-sort var1372 0)
(declare-sort var3246 0)
(declare-sort var361 0)
(declare-sort var3444 0)
(declare-sort var2893 0)
(declare-sort var2844 0)
(declare-sort var870 0)
(declare-sort var1744 0)
(declare-sort var554 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun children/-624348126 (var1372) var3246)
(declare-fun var3246_isEmpty/-153543822 (var3246) Bool)
(declare-fun var361_length/1485543905 (String) Int)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun val$treeSB/-1943720399 (var1459) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun this$0/-1943720399 (var1459) var3444)
(declare-fun var3444_access$100/1960619880 (var3444) Bool)
(declare-fun var2893-init () var2893)
(declare-fun var2844-init () var2844)
(declare-fun data/-624348126 (var1372) var870)
(declare-fun toString/-522406933 (var870) String)
(declare-fun <init>/814598262 (var2844 String) void)
(declare-fun <init>/-2021156853 (var2893 var1744) void)
(declare-fun cast-from-var2844-to-var1744 (var2844) var1744)
(declare-fun addSuppressed/-2013977960 (var554 var554) void)
(declare-const null-var1459 var1459)
(declare-const null-Int Int)
(declare-const null-Bool Bool)
(declare-const null-String String)
(declare-const null-var1372 var1372)
(declare-const null-var554 var554)
(declare-const var3417 var1459) ; Statement: r2 := @this: org.apache.dubbo.qos.textui.TTree$1 
(assert (not (= var3417 null-var1459)))
(declare-const var1264 Int) ; Statement: i7 := @parameter0: int 
(assert (not (= var1264 null-Int)))
(declare-const var1357 Bool) ; Statement: z2 := @parameter1: boolean 
(assert (not (= var1357 null-Bool)))
(declare-const var3472 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var3472 null-String)))
(declare-const var365 var1372) ; Statement: r0 := @parameter3: org.apache.dubbo.qos.textui.TTree$Node 
(assert (not (= var365 null-var1372)))
(define-const var3946 var3246 (children/-624348126 var365)) ; Statement: $r1 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.util.List children> 
(define-const var3174 Bool (var3246_isEmpty/-153543822 var3946)) ; Statement: $z0 = interfaceinvoke $r1.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z0 != 0 goto $z5 = 0 
(assert (not (= (ite var3174 1 0) 0))) ; Cond: $z0 != 0 
(define-const var780 Bool (ite (= 1 0) true false)) ; Statement: $z5 = 0 
(assert true) ; Non Conditional
(define-const var370 Bool var780) ; Statement: z1 = $z5 
 ; Statement: if z2 == 0 goto $r37 = "+---" 
(assert (not (= (ite var1357 1 0) 0))) ; Negate: Cond: z2 == 0  
(define-const var2956 String "`---") ; Statement: $r37 = "`---" 
(define-const var106 String "`---") ; Statement: $r36 = "`---" 
 ; Statement: goto [?= $i6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>($r37)] 
(assert true) ; Non Conditional
(define-const var585 Int (var361_length/1485543905 (cast-from-String-to-String var2956))) ; Statement: $i6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>($r37) 
(define-const var3522 String (val$treeSB/-1943720399 var3417)) ; Statement: $r4 = r2.<org.apache.dubbo.qos.textui.TTree$1: java.lang.StringBuilder val$treeSB> 
(assert true)
(define-const var3183 String (append/672562846 var3522 var3472)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var3522!1 String)
(assert (= var3522!1 (str.++ var3522 var3472)))
(assert true)
;(assert (append/672562846 var3183 var106)) ; Statement: virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r36) 
(declare-const var3183!1 String)
(assert (= var3183!1 (str.++ var3183 var106)))
(define-const var2816 Int 0) ; Statement: i8 = 0 
 ; Statement: if z1 == 0 goto $r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0> 
(assert (= (ite var370 1 0) 0)) ; Cond: z1 == 0 
(define-const var221 var3444 (this$0/-1943720399 var3417)) ; Statement: $r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0> 
(define-const var281 Bool (var3444_access$100/1960619880 var221)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.qos.textui.TTree: boolean access$100(org.apache.dubbo.qos.textui.TTree)>($r6) 
 ; Statement: if $z3 == 0 goto $r31 = new java.util.Scanner 
(assert (= (ite var281 1 0) 0)) ; Cond: $z3 == 0 
(define-const var2992 var2893 var2893-init) ; Statement: $r31 = new java.util.Scanner 
(define-const var224 var2844 var2844-init) ; Statement: $r32 = new java.io.StringReader 
(define-const var948 var870 (data/-624348126 var365)) ; Statement: $r33 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.lang.Object data> 
(assert true)
(define-const var2054 String (toString/-522406933 var948)) ; Statement: $r34 = virtualinvoke $r33.<java.lang.Object: java.lang.String toString()>() 
(assert true)
;(assert (<init>/814598262 var224 var2054)) ; Statement: specialinvoke $r32.<java.io.StringReader: void <init>(java.lang.String)>($r34) 

(declare-const var224!1 var2844)
(declare-const var2054!1 String)
(assert true)
;(assert (<init>/-2021156853 var2992 (cast-from-var2844-to-var1744 var224!1))) ; Statement: specialinvoke $r31.<java.util.Scanner: void <init>(java.lang.Readable)>($r32) 

(declare-const var2992!1 var2893)
(declare-const var224!2 var2844)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2546 var554) ; Statement: $r28 := @caughtexception 
(assert (not (= var2546 null-var554)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3632 var554) ; Statement: $r27 := @caughtexception 
(assert (not (= var3632 null-var554)))
(assert true)
;(assert (addSuppressed/-2013977960 var2546 var3632)) ; Statement: virtualinvoke $r28.<java.lang.Throwable: void addSuppressed(java.lang.Throwable)>($r27) 

(declare-const var2546!1 var554)
(declare-const var3632!1 var554)
(assert true) ; Non Conditional
 ; Statement: throw $r28 
(check-sat)
; {children/-624348126=([org.apache.dubbo.qos.textui.TTree$Node], java.util.List), var3246_isEmpty/-153543822=([java.util.List], boolean), var361_length/1485543905=([java.lang.CharSequence], int), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), val$treeSB/-1943720399=([org.apache.dubbo.qos.textui.TTree$1], java.lang.StringBuilder), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), this$0/-1943720399=([org.apache.dubbo.qos.textui.TTree$1], org.apache.dubbo.qos.textui.TTree), var3444_access$100/1960619880=([org.apache.dubbo.qos.textui.TTree], boolean), var2893-init=([], java.util.Scanner), var2844-init=([], java.io.StringReader), data/-624348126=([org.apache.dubbo.qos.textui.TTree$Node], java.lang.Object), toString/-522406933=([java.lang.Object], java.lang.String), <init>/814598262=([java.io.StringReader, java.lang.String], void), <init>/-2021156853=([java.util.Scanner, java.lang.Readable], void), cast-from-var2844-to-var1744=([java.io.StringReader], java.lang.Readable), addSuppressed/-2013977960=([java.lang.Throwable, java.lang.Throwable], void)}
; {var1459=org.apache.dubbo.qos.textui.TTree$1, var3417=r2, var1264=i7, var1357=z2, var3472=r3, var552=null_type, var1372=org.apache.dubbo.qos.textui.TTree$Node, var365=r0, var3246=java.util.List, var3946=$r1, var3174=$z0, var780=$z5, var370=z1, var2956=$r37, var106=$r36, var361=org.apache.dubbo.common.utils.StringUtils, var585=$i6, var3522=$r4, var3183=$r5, var2816=i8, var3444=org.apache.dubbo.qos.textui.TTree, var221=$r6, var281=$z3, var2893=java.util.Scanner, var2992=$r31, var2844=java.io.StringReader, var224=$r32, var870=java.lang.Object, var948=$r33, var2054=$r34, var1744=java.lang.Readable, var554=java.lang.Throwable, var2546=$r28, var3632=$r27}
; {org.apache.dubbo.qos.textui.TTree$1=var1459, r2=var3417, i7=var1264, z2=var1357, r3=var3472, null_type=var552, org.apache.dubbo.qos.textui.TTree$Node=var1372, r0=var365, java.util.List=var3246, $r1=var3946, $z0=var3174, $z5=var780, z1=var370, $r37=var2956, $r36=var106, org.apache.dubbo.common.utils.StringUtils=var361, $i6=var585, $r4=var3522, $r5=var3183, i8=var2816, org.apache.dubbo.qos.textui.TTree=var3444, $r6=var221, $z3=var281, java.util.Scanner=var2893, $r31=var2992, java.io.StringReader=var2844, $r32=var224, java.lang.Object=var870, $r33=var948, $r34=var2054, java.lang.Readable=var1744, java.lang.Throwable=var554, $r28=var2546, $r27=var3632}
;seq <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r2 := @this: org.apache.dubbo.qos.textui.TTree$1;	i7 := @parameter0: int;	z2 := @parameter1: boolean;	r3 := @parameter2: java.lang.String;	r0 := @parameter3: org.apache.dubbo.qos.textui.TTree$Node;	$r1 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.util.List children>;	$z0 = interfaceinvoke $r1.<java.util.List: boolean isEmpty()>();	if $z0 != 0 goto $z5 = 0;	$z5 = 0;	z1 = $z5;	if z2 == 0 goto $r37 = "+---";	$r37 = "`---";	$r36 = "`---";	goto [?= $i6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>($r37)];	$i6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>($r37);	$r4 = r2.<org.apache.dubbo.qos.textui.TTree$1: java.lang.StringBuilder val$treeSB>;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r36);	i8 = 0;	if z1 == 0 goto $r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0>;	$r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0>;	$z3 = staticinvoke <org.apache.dubbo.qos.textui.TTree: boolean access$100(org.apache.dubbo.qos.textui.TTree)>($r6);	if $z3 == 0 goto $r31 = new java.util.Scanner;	$r31 = new java.util.Scanner;	$r32 = new java.io.StringReader;	$r33 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.lang.Object data>;	$r34 = virtualinvoke $r33.<java.lang.Object: java.lang.String toString()>();	specialinvoke $r32.<java.io.StringReader: void <init>(java.lang.String)>($r34);	specialinvoke $r31.<java.util.Scanner: void <init>(java.lang.Readable)>($r32);	$r28 := @caughtexception;	$r27 := @caughtexception;	virtualinvoke $r28.<java.lang.Throwable: void addSuppressed(java.lang.Throwable)>($r27);	throw $r28
;block_num 10