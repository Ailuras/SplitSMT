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

(declare-sort var2432 0)
(declare-sort var3923 0)
(declare-sort var2382 0)
(declare-sort var672 0)
(declare-sort var2141 0)
(declare-sort var2991 0)
(declare-sort var3301 0)
(declare-sort var453 0)
(declare-sort var1875 0)
(declare-sort var253 0)
(declare-sort var3373 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun children/-624348126 (var2382) var672)
(declare-fun var672_isEmpty/-153543822 (var672) Bool)
(declare-fun var2141_length/1485543905 (String) Int)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun val$treeSB/-1943720399 (var2432) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun this$0/-1943720399 (var2432) var2991)
(declare-fun var2991_access$100/1960619880 (var2991) Bool)
(declare-fun var3301-init () var3301)
(declare-fun var453-init () var453)
(declare-fun data/-624348126 (var2382) var1875)
(declare-fun toString/-522406933 (var1875) String)
(declare-fun <init>/814598262 (var453 String) void)
(declare-fun <init>/-2021156853 (var3301 var253) void)
(declare-fun cast-from-var453-to-var253 (var453) var253)
(declare-fun addSuppressed/-2013977960 (var3373 var3373) void)
(declare-const null-var2432 var2432)
(declare-const null-Int Int)
(declare-const null-Bool Bool)
(declare-const null-String String)
(declare-const null-var2382 var2382)
(declare-const null-var3373 var3373)
(declare-const var2927 var2432) ; Statement: r2 := @this: org.apache.dubbo.qos.textui.TTree$1 
(assert (not (= var2927 null-var2432)))
(declare-const var2572 Int) ; Statement: i7 := @parameter0: int 
(assert (not (= var2572 null-Int)))
(declare-const var1673 Bool) ; Statement: z2 := @parameter1: boolean 
(assert (not (= var1673 null-Bool)))
(declare-const var134 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var134 null-String)))
(declare-const var2866 var2382) ; Statement: r0 := @parameter3: org.apache.dubbo.qos.textui.TTree$Node 
(assert (not (= var2866 null-var2382)))
(define-const var2158 var672 (children/-624348126 var2866)) ; Statement: $r1 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.util.List children> 
(define-const var2168 Bool (var672_isEmpty/-153543822 var2158)) ; Statement: $z0 = interfaceinvoke $r1.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z0 != 0 goto $z5 = 0 
(assert (not (= (ite var2168 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3909 Bool (ite (= 1 0) true false)) ; Statement: $z5 = 0 
(assert true) ; Non Conditional
(define-const var339 Bool var3909) ; Statement: z1 = $z5 
 ; Statement: if z2 == 0 goto $r37 = "+---" 
(assert (= (ite var1673 1 0) 0)) ; Cond: z2 == 0 
(define-const var1926 String "+---") ; Statement: $r37 = "+---" 
(define-const var3393 String "+---") ; Statement: $r36 = "+---" 
(assert true) ; Non Conditional
(define-const var3320 Int (var2141_length/1485543905 (cast-from-String-to-String var1926))) ; Statement: $i6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>($r37) 
(define-const var2339 String (val$treeSB/-1943720399 var2927)) ; Statement: $r4 = r2.<org.apache.dubbo.qos.textui.TTree$1: java.lang.StringBuilder val$treeSB> 
(assert true)
(define-const var2042 String (append/672562846 var2339 var134)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var2339!1 String)
(assert (= var2339!1 (str.++ var2339 var134)))
(assert true)
;(assert (append/672562846 var2042 var3393)) ; Statement: virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r36) 
(declare-const var2042!1 String)
(assert (= var2042!1 (str.++ var2042 var3393)))
(define-const var1638 Int 0) ; Statement: i8 = 0 
 ; Statement: if z1 == 0 goto $r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0> 
(assert (= (ite var339 1 0) 0)) ; Cond: z1 == 0 
(define-const var3256 var2991 (this$0/-1943720399 var2927)) ; Statement: $r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0> 
(define-const var2243 Bool (var2991_access$100/1960619880 var3256)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.qos.textui.TTree: boolean access$100(org.apache.dubbo.qos.textui.TTree)>($r6) 
 ; Statement: if $z3 == 0 goto $r31 = new java.util.Scanner 
(assert (= (ite var2243 1 0) 0)) ; Cond: $z3 == 0 
(define-const var2006 var3301 var3301-init) ; Statement: $r31 = new java.util.Scanner 
(define-const var3792 var453 var453-init) ; Statement: $r32 = new java.io.StringReader 
(define-const var1132 var1875 (data/-624348126 var2866)) ; Statement: $r33 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.lang.Object data> 
(assert true)
(define-const var2483 String (toString/-522406933 var1132)) ; Statement: $r34 = virtualinvoke $r33.<java.lang.Object: java.lang.String toString()>() 
(assert true)
;(assert (<init>/814598262 var3792 var2483)) ; Statement: specialinvoke $r32.<java.io.StringReader: void <init>(java.lang.String)>($r34) 

(declare-const var3792!1 var453)
(declare-const var2483!1 String)
(assert true)
;(assert (<init>/-2021156853 var2006 (cast-from-var453-to-var253 var3792!1))) ; Statement: specialinvoke $r31.<java.util.Scanner: void <init>(java.lang.Readable)>($r32) 

(declare-const var2006!1 var3301)
(declare-const var3792!2 var453)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2990 var3373) ; Statement: $r28 := @caughtexception 
(assert (not (= var2990 null-var3373)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3760 var3373) ; Statement: $r27 := @caughtexception 
(assert (not (= var3760 null-var3373)))
(assert true)
;(assert (addSuppressed/-2013977960 var2990 var3760)) ; Statement: virtualinvoke $r28.<java.lang.Throwable: void addSuppressed(java.lang.Throwable)>($r27) 

(declare-const var2990!1 var3373)
(declare-const var3760!1 var3373)
(assert true) ; Non Conditional
 ; Statement: throw $r28 
(check-sat)
; {children/-624348126=([org.apache.dubbo.qos.textui.TTree$Node], java.util.List), var672_isEmpty/-153543822=([java.util.List], boolean), var2141_length/1485543905=([java.lang.CharSequence], int), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), val$treeSB/-1943720399=([org.apache.dubbo.qos.textui.TTree$1], java.lang.StringBuilder), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), this$0/-1943720399=([org.apache.dubbo.qos.textui.TTree$1], org.apache.dubbo.qos.textui.TTree), var2991_access$100/1960619880=([org.apache.dubbo.qos.textui.TTree], boolean), var3301-init=([], java.util.Scanner), var453-init=([], java.io.StringReader), data/-624348126=([org.apache.dubbo.qos.textui.TTree$Node], java.lang.Object), toString/-522406933=([java.lang.Object], java.lang.String), <init>/814598262=([java.io.StringReader, java.lang.String], void), <init>/-2021156853=([java.util.Scanner, java.lang.Readable], void), cast-from-var453-to-var253=([java.io.StringReader], java.lang.Readable), addSuppressed/-2013977960=([java.lang.Throwable, java.lang.Throwable], void)}
; {var2432=org.apache.dubbo.qos.textui.TTree$1, var2927=r2, var2572=i7, var1673=z2, var134=r3, var3923=null_type, var2382=org.apache.dubbo.qos.textui.TTree$Node, var2866=r0, var672=java.util.List, var2158=$r1, var2168=$z0, var3909=$z5, var339=z1, var1926=$r37, var3393=$r36, var2141=org.apache.dubbo.common.utils.StringUtils, var3320=$i6, var2339=$r4, var2042=$r5, var1638=i8, var2991=org.apache.dubbo.qos.textui.TTree, var3256=$r6, var2243=$z3, var3301=java.util.Scanner, var2006=$r31, var453=java.io.StringReader, var3792=$r32, var1875=java.lang.Object, var1132=$r33, var2483=$r34, var253=java.lang.Readable, var3373=java.lang.Throwable, var2990=$r28, var3760=$r27}
; {org.apache.dubbo.qos.textui.TTree$1=var2432, r2=var2927, i7=var2572, z2=var1673, r3=var134, null_type=var3923, org.apache.dubbo.qos.textui.TTree$Node=var2382, r0=var2866, java.util.List=var672, $r1=var2158, $z0=var2168, $z5=var3909, z1=var339, $r37=var1926, $r36=var3393, org.apache.dubbo.common.utils.StringUtils=var2141, $i6=var3320, $r4=var2339, $r5=var2042, i8=var1638, org.apache.dubbo.qos.textui.TTree=var2991, $r6=var3256, $z3=var2243, java.util.Scanner=var3301, $r31=var2006, java.io.StringReader=var453, $r32=var3792, java.lang.Object=var1875, $r33=var1132, $r34=var2483, java.lang.Readable=var253, java.lang.Throwable=var3373, $r28=var2990, $r27=var3760}
;seq <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2}
;stmts r2 := @this: org.apache.dubbo.qos.textui.TTree$1;	i7 := @parameter0: int;	z2 := @parameter1: boolean;	r3 := @parameter2: java.lang.String;	r0 := @parameter3: org.apache.dubbo.qos.textui.TTree$Node;	$r1 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.util.List children>;	$z0 = interfaceinvoke $r1.<java.util.List: boolean isEmpty()>();	if $z0 != 0 goto $z5 = 0;	$z5 = 0;	z1 = $z5;	if z2 == 0 goto $r37 = "+---";	$r37 = "+---";	$r36 = "+---";	$i6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>($r37);	$r4 = r2.<org.apache.dubbo.qos.textui.TTree$1: java.lang.StringBuilder val$treeSB>;	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r36);	i8 = 0;	if z1 == 0 goto $r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0>;	$r6 = r2.<org.apache.dubbo.qos.textui.TTree$1: org.apache.dubbo.qos.textui.TTree this$0>;	$z3 = staticinvoke <org.apache.dubbo.qos.textui.TTree: boolean access$100(org.apache.dubbo.qos.textui.TTree)>($r6);	if $z3 == 0 goto $r31 = new java.util.Scanner;	$r31 = new java.util.Scanner;	$r32 = new java.io.StringReader;	$r33 = r0.<org.apache.dubbo.qos.textui.TTree$Node: java.lang.Object data>;	$r34 = virtualinvoke $r33.<java.lang.Object: java.lang.String toString()>();	specialinvoke $r32.<java.io.StringReader: void <init>(java.lang.String)>($r34);	specialinvoke $r31.<java.util.Scanner: void <init>(java.lang.Readable)>($r32);	$r28 := @caughtexception;	$r27 := @caughtexception;	virtualinvoke $r28.<java.lang.Throwable: void addSuppressed(java.lang.Throwable)>($r27);	throw $r28
;block_num 10