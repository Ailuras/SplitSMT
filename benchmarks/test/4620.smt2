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

(declare-sort var3083 0)
(declare-sort var2462 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mSize/1311397614 (var3083) Int)
(declare-fun var2462-init () var2462)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1107025377 (var2462 String) void)
(declare-const null-var3083 var3083)
(declare-const null-Int Int)
(declare-const var2524 var3083) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Stack 
(assert (not (= var2524 null-var3083)))
(declare-const var2081 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2081 null-Int)))
(define-const var98 Int (mSize/1311397614 var2524)) ; Statement: $i1 = r0.<org.apache.dubbo.common.utils.Stack: int mSize> 
 ; Statement: if i0 >= $i1 goto $r1 = new java.lang.IndexOutOfBoundsException 
(assert (not (>= var2081 var98))) ; Negate: Cond: i0 >= $i1  
(define-const var3341 Int (mSize/1311397614 var2524)) ; Statement: $i3 = r0.<org.apache.dubbo.common.utils.Stack: int mSize> 
(define-const var988 Int (+ var2081 var3341)) ; Statement: $i4 = i0 + $i3 
 ; Statement: if $i4 >= 0 goto (branch) 
(assert (not (>= var988 0))) ; Negate: Cond: $i4 >= 0  
(define-const var2736 var2462 var2462-init) ; Statement: $r1 = new java.lang.IndexOutOfBoundsException 
(define-const var563 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var563)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var563!1 String)
(assert (= var563!1 ""))
(assert true)
(define-const var2539 String (append/672562846 var563!1 "Index: ")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Index: ") 
(declare-const var563!2 String)
(assert (= var563!2 (str.++ var563!1 "Index: ")))
(assert true)
(define-const var3905 String (append/-1001720160 var2539 var2081)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var2539!1 String)
(assert (str.prefixof var2539 var2539!1))
(assert true)
(define-const var2705 String (append/672562846 var3905 ", Size: ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Size: ") 
(declare-const var3905!1 String)
(assert (= var3905!1 (str.++ var3905 ", Size: ")))
(define-const var2906 Int (mSize/1311397614 var2524)) ; Statement: $i2 = r0.<org.apache.dubbo.common.utils.Stack: int mSize> 
(assert true)
(define-const var3575 String (append/-1001720160 var2705 var2906)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var2705!1 String)
(assert (str.prefixof var2705 var2705!1))
(assert true)
(define-const var2749 String (toString/-2075883882 var3575)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1107025377 var2736 var2749)) ; Statement: specialinvoke $r1.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r7) 

(declare-const var2736!1 var2462)
(declare-const var2749!1 String)
 ; Statement: throw $r1 
(check-sat)
; {mSize/1311397614=([org.apache.dubbo.common.utils.Stack], int), var2462-init=([], java.lang.IndexOutOfBoundsException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1107025377=([java.lang.IndexOutOfBoundsException, java.lang.String], void)}
; {var3083=org.apache.dubbo.common.utils.Stack, var2524=r0, var2081=i0, var98=$i1, var3341=$i3, var988=$i4, var2462=java.lang.IndexOutOfBoundsException, var2736=$r1, var563=$r2, var2539=$r3, var3905=$r4, var2705=$r5, var2906=$i2, var3575=$r6, var2749=$r7}
; {org.apache.dubbo.common.utils.Stack=var3083, r0=var2524, i0=var2081, $i1=var98, $i3=var3341, $i4=var988, java.lang.IndexOutOfBoundsException=var2462, $r1=var2736, $r2=var563, $r3=var2539, $r4=var3905, $r5=var2705, $i2=var2906, $r6=var3575, $r7=var2749}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.Stack;	i0 := @parameter0: int;	$i1 = r0.<org.apache.dubbo.common.utils.Stack: int mSize>;	if i0 >= $i1 goto $r1 = new java.lang.IndexOutOfBoundsException;	$i3 = r0.<org.apache.dubbo.common.utils.Stack: int mSize>;	$i4 = i0 + $i3;	if $i4 >= 0 goto (branch);	$r1 = new java.lang.IndexOutOfBoundsException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Index: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Size: ");	$i2 = r0.<org.apache.dubbo.common.utils.Stack: int mSize>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r7);	throw $r1
;block_num 3