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

(declare-sort var1807 0)
(declare-sort var781 0)
(declare-sort var1688 0)
(declare-sort var496 0)
(declare-sort var1678 0)
(declare-sort var462 0)
(declare-sort var270 0)
(declare-sort var2548 0)
(declare-sort var3642 0)
(declare-sort var111 0)
(declare-sort var2867 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun children/-624348126 (var1688) var496)
(declare-fun var496_isEmpty/-153543822 (var496) Bool)
(declare-fun var1678_length/1485543905 (String) Int)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun val$treeSB/-1943720399 (var1807) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun this$0/-1943720399 (var1807) var462)
(declare-fun var462_access$100/1960619880 (var462) Bool)
(declare-fun var270-init () var270)
(declare-fun var2548-init () var2548)
(declare-fun data/-624348126 (var1688) var3642)
(declare-fun toString/-522406933 (var3642) String)
(declare-fun <init>/814598262 (var2548 String) void)
(declare-fun <init>/-2021156853 (var270 var111) void)
(declare-fun cast-from-var2548-to-var111 (var2548) var111)
(declare-fun addSuppressed/-2013977960 (var2867 var2867) void)
(declare-const null-var1807 var1807)
(declare-const null-Int Int)
(declare-const null-Bool Bool)
(declare-const null-String String)
(declare-const null-var1688 var1688)
(declare-const null-var2867 var2867)
(declare-const var2640 var1807) ; Statement: r2 := @this: org.apache.dubbo.qos.textui.TTree$1 
(assert (not (= var2640 null-var1807)))
(declare-const var2457 Int) ; Statement: i7 := @parameter0: int 
(assert (not (= var2457 null-Int)))
(declare-const var135 Bool) ; Statement: z2 := @parameter1: boolean 
(assert (not (= var135 null-Bool)))
(declare-const var1761 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var1761 null-String)))
(declare-const var3814 var1688) ; Statement: r0 := @parameter3: org.apache.dubbo.qos.textui.TTree$Node 
(assert (not (= var3814 null-var1688)))
(define-const var2564 var496 (children/-624348126 var3814)) ; Statement: $r1 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.util.List children> 
(define-const var37 Bool (var496_isEmpty/-153543822 var2564)) ; Statement: $z0 = interfaceinvoke $r1.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z0 != 0 goto $z5 = 0 
(assert (not (not (= (ite var37 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3001 Bool (ite (= 1 1) true false)) ; Statement: $z5 = 1 
 ; Statement: goto [?= z1 = $z5] 
(assert true) ; Non Conditional
(define-const var1345 Bool var3001) ; Statement: z1 = $z5 
 ; Statement: if z2 == 0 goto $r37 = "+---" 
(assert (not (= (ite var135 1 0) 0))) ; Negate: Cond: z2 == 0  
(define-const var1148 String "`---") ; Statement: $r37 = "`---" 
(define-const var2351 String "`---") ; Statement: $r36 = "`---" 
 ; Statement: goto [?= $i6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>($r37)] 
(assert true) ; Non Conditional
(define-const var2019 Int (var1678_length/1485543905 (cast-from-String-to-String var1148))) ; Statement: $i6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>($r37) 
(define-const var2324 String (val$treeSB/-1943720399 var2640)) ; Statement: $r4 = r2.<org.apache.dubbo.qos.textui.TTree$1: java.lang.StringBuilder val$treeSB> 
(assert true)
(define-const var2293 String (append/672562846 var2324 var1761)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var2324!1 String)
(assert (= var2324!1 (str.++ var2324 var1761)))
(assert true)
;(assert (append/672562846 var2293 var2351)) ; Statement: virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r36) 
(declare-const var2293!1 String)
(assert (= var2293!1 (str.++ var2293 var2351)))
(define-const var2604 Int 0) ; Statement: i8 = 0 
 ; Statement: if z1 == 0 goto $r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0> 
(assert (= (ite var1345 1 0) 0)) ; Cond: z1 == 0 
(define-const var3019 var462 (this$0/-1943720399 var2640)) ; Statement: $r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0> 
(define-const var2814 Bool (var462_access$100/1960619880 var3019)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.qos.textui.TTree: boolean access$100(org.apache.dubbo.qos.textui.TTree)>($r6) 
 ; Statement: if $z3 == 0 goto $r31 = new java.util.Scanner 
(assert (= (ite var2814 1 0) 0)) ; Cond: $z3 == 0 
(define-const var3371 var270 var270-init) ; Statement: $r31 = new java.util.Scanner 
(define-const var22 var2548 var2548-init) ; Statement: $r32 = new java.io.StringReader 
(define-const var2371 var3642 (data/-624348126 var3814)) ; Statement: $r33 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.lang.Object data> 
(assert true)
(define-const var1966 String (toString/-522406933 var2371)) ; Statement: $r34 = virtualinvoke $r33.<java.lang.Object: java.lang.String toString()>() 
(assert true)
;(assert (<init>/814598262 var22 var1966)) ; Statement: specialinvoke $r32.<java.io.StringReader: void <init>(java.lang.String)>($r34) 

(declare-const var22!1 var2548)
(declare-const var1966!1 String)
(assert true)
;(assert (<init>/-2021156853 var3371 (cast-from-var2548-to-var111 var22!1))) ; Statement: specialinvoke $r31.<java.util.Scanner: void <init>(java.lang.Readable)>($r32) 

(declare-const var3371!1 var270)
(declare-const var22!2 var2548)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1647 var2867) ; Statement: $r28 := @caughtexception 
(assert (not (= var1647 null-var2867)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1312 var2867) ; Statement: $r27 := @caughtexception 
(assert (not (= var1312 null-var2867)))
(assert true)
;(assert (addSuppressed/-2013977960 var1647 var1312)) ; Statement: virtualinvoke $r28.<java.lang.Throwable: void addSuppressed(java.lang.Throwable)>($r27) 

(declare-const var1647!1 var2867)
(declare-const var1312!1 var2867)
(assert true) ; Non Conditional
 ; Statement: throw $r28 
(check-sat)
; {children/-624348126=([org.apache.dubbo.qos.textui.TTree$Node], java.util.List), var496_isEmpty/-153543822=([java.util.List], boolean), var1678_length/1485543905=([java.lang.CharSequence], int), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), val$treeSB/-1943720399=([org.apache.dubbo.qos.textui.TTree$1], java.lang.StringBuilder), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), this$0/-1943720399=([org.apache.dubbo.qos.textui.TTree$1], org.apache.dubbo.qos.textui.TTree), var462_access$100/1960619880=([org.apache.dubbo.qos.textui.TTree], boolean), var270-init=([], java.util.Scanner), var2548-init=([], java.io.StringReader), data/-624348126=([org.apache.dubbo.qos.textui.TTree$Node], java.lang.Object), toString/-522406933=([java.lang.Object], java.lang.String), <init>/814598262=([java.io.StringReader, java.lang.String], void), <init>/-2021156853=([java.util.Scanner, java.lang.Readable], void), cast-from-var2548-to-var111=([java.io.StringReader], java.lang.Readable), addSuppressed/-2013977960=([java.lang.Throwable, java.lang.Throwable], void)}
; {var1807=org.apache.dubbo.qos.textui.TTree$1, var2640=r2, var2457=i7, var135=z2, var1761=r3, var781=null_type, var1688=org.apache.dubbo.qos.textui.TTree$Node, var3814=r0, var496=java.util.List, var2564=$r1, var37=$z0, var3001=$z5, var1345=z1, var1148=$r37, var2351=$r36, var1678=org.apache.dubbo.common.utils.StringUtils, var2019=$i6, var2324=$r4, var2293=$r5, var2604=i8, var462=org.apache.dubbo.qos.textui.TTree, var3019=$r6, var2814=$z3, var270=java.util.Scanner, var3371=$r31, var2548=java.io.StringReader, var22=$r32, var3642=java.lang.Object, var2371=$r33, var1966=$r34, var111=java.lang.Readable, var2867=java.lang.Throwable, var1647=$r28, var1312=$r27}
; {org.apache.dubbo.qos.textui.TTree$1=var1807, r2=var2640, i7=var2457, z2=var135, r3=var1761, null_type=var781, org.apache.dubbo.qos.textui.TTree$Node=var1688, r0=var3814, java.util.List=var496, $r1=var2564, $z0=var37, $z5=var3001, z1=var1345, $r37=var1148, $r36=var2351, org.apache.dubbo.common.utils.StringUtils=var1678, $i6=var2019, $r4=var2324, $r5=var2293, i8=var2604, org.apache.dubbo.qos.textui.TTree=var462, $r6=var3019, $z3=var2814, java.util.Scanner=var270, $r31=var3371, java.io.StringReader=var2548, $r32=var22, java.lang.Object=var3642, $r33=var2371, $r34=var1966, java.lang.Readable=var111, java.lang.Throwable=var2867, $r28=var1647, $r27=var1312}
;seq <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r2 := @this: org.apache.dubbo.qos.textui.TTree$1;	i7 := @parameter0: int;	z2 := @parameter1: boolean;	r3 := @parameter2: java.lang.String;	r0 := @parameter3: org.apache.dubbo.qos.textui.TTree$Node;	$r1 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.util.List children>;	$z0 = interfaceinvoke $r1.<java.util.List: boolean isEmpty()>();	if $z0 != 0 goto $z5 = 0;	$z5 = 1;	goto [?= z1 = $z5];	z1 = $z5;	if z2 == 0 goto $r37 = "+---";	$r37 = "`---";	$r36 = "`---";	goto [?= $i6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>($r37)];	$i6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>($r37);	$r4 = r2.<org.apache.dubbo.qos.textui.TTree$1: java.lang.StringBuilder val$treeSB>;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r36);	i8 = 0;	if z1 == 0 goto $r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0>;	$r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0>;	$z3 = staticinvoke <org.apache.dubbo.qos.textui.TTree: boolean access$100(org.apache.dubbo.qos.textui.TTree)>($r6);	if $z3 == 0 goto $r31 = new java.util.Scanner;	$r31 = new java.util.Scanner;	$r32 = new java.io.StringReader;	$r33 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.lang.Object data>;	$r34 = virtualinvoke $r33.<java.lang.Object: java.lang.String toString()>();	specialinvoke $r32.<java.io.StringReader: void <init>(java.lang.String)>($r34);	specialinvoke $r31.<java.util.Scanner: void <init>(java.lang.Readable)>($r32);	$r28 := @caughtexception;	$r27 := @caughtexception;	virtualinvoke $r28.<java.lang.Throwable: void addSuppressed(java.lang.Throwable)>($r27);	throw $r28
;block_num 10