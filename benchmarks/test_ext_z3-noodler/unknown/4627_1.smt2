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

(declare-sort var2027 0)
(declare-sort var3442 0)
(declare-sort var2715 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mSize/1311397614 (var2027) Int)
(declare-fun var2715-init () var2715)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1107025377 (var2715 String) void)
(declare-const null-var2027 var2027)
(declare-const null-Int Int)
(declare-const null-var3442 var3442)
(declare-const var1406 var2027) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Stack 
(assert (not (= var1406 null-var2027)))
(declare-const var1157 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1157 null-Int)))
(declare-const var3488 var3442) ; Statement: r8 := @parameter1: java.lang.Object 
(assert (not (= var3488 null-var3442)))
(define-const var1570 Int (mSize/1311397614 var1406)) ; Statement: $i1 = r0.<org.apache.dubbo.common.utils.Stack: int mSize> 
 ; Statement: if i0 >= $i1 goto $r1 = new java.lang.IndexOutOfBoundsException 
(assert (>= var1157 var1570)) ; Cond: i0 >= $i1 
(define-const var862 var2715 var2715-init) ; Statement: $r1 = new java.lang.IndexOutOfBoundsException 
(define-const var514 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var514)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var514!1 String)
(assert (= var514!1 ""))
(assert true)
(define-const var817 String (append/672562846 var514!1 "Index: ")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Index: ") 
(declare-const var514!2 String)
(assert (= var514!2 (str.++ var514!1 "Index: ")))
(assert true)
(define-const var48 String (append/-1001720160 var817 var1157)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var817!1 String)
(assert (str.prefixof var817 var817!1))
(assert true)
(define-const var1233 String (append/672562846 var48 ", Size: ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Size: ") 
(declare-const var48!1 String)
(assert (= var48!1 (str.++ var48 ", Size: ")))
(define-const var2775 Int (mSize/1311397614 var1406)) ; Statement: $i2 = r0.<org.apache.dubbo.common.utils.Stack: int mSize> 
(assert true)
(define-const var3098 String (append/-1001720160 var1233 var2775)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var1233!1 String)
(assert (str.prefixof var1233 var1233!1))
(assert true)
(define-const var1091 String (toString/-2075883882 var3098)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1107025377 var862 var1091)) ; Statement: specialinvoke $r1.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r7) 

(declare-const var862!1 var2715)
(declare-const var1091!1 String)
 ; Statement: throw $r1 
(check-sat)
; {mSize/1311397614=([org.apache.dubbo.common.utils.Stack], int), var2715-init=([], java.lang.IndexOutOfBoundsException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1107025377=([java.lang.IndexOutOfBoundsException, java.lang.String], void)}
; {var2027=org.apache.dubbo.common.utils.Stack, var1406=r0, var1157=i0, var3442=java.lang.Object, var3488=r8, var1570=$i1, var2715=java.lang.IndexOutOfBoundsException, var862=$r1, var514=$r2, var817=$r3, var48=$r4, var1233=$r5, var2775=$i2, var3098=$r6, var1091=$r7}
; {org.apache.dubbo.common.utils.Stack=var2027, r0=var1406, i0=var1157, java.lang.Object=var3442, r8=var3488, $i1=var1570, java.lang.IndexOutOfBoundsException=var2715, $r1=var862, $r2=var514, $r3=var817, $r4=var48, $r5=var1233, $i2=var2775, $r6=var3098, $r7=var1091}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.Stack;	i0 := @parameter0: int;	r8 := @parameter1: java.lang.Object;	$i1 = r0.<org.apache.dubbo.common.utils.Stack: int mSize>;	if i0 >= $i1 goto $r1 = new java.lang.IndexOutOfBoundsException;	$r1 = new java.lang.IndexOutOfBoundsException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Index: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Size: ");	$i2 = r0.<org.apache.dubbo.common.utils.Stack: int mSize>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r7);	throw $r1
;block_num 2