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

(declare-sort var3363 0)
(declare-sort var420 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mSize/1311397614 (var3363) Int)
(declare-fun var420-init () var420)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1107025377 (var420 String) void)
(declare-const null-var3363 var3363)
(declare-const null-Int Int)
(declare-const var3974 var3363) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Stack 
(assert (not (= var3974 null-var3363)))
(declare-const var1055 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var1055 null-Int)))
(define-const var2242 Int (mSize/1311397614 var3974)) ; Statement: $i1 = r0.<org.apache.dubbo.common.utils.Stack: int mSize> 
 ; Statement: if i0 >= $i1 goto $r1 = new java.lang.IndexOutOfBoundsException 
(assert (>= var1055 var2242)) ; Cond: i0 >= $i1 
(define-const var1181 var420 var420-init) ; Statement: $r1 = new java.lang.IndexOutOfBoundsException 
(define-const var3990 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3990)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3990!1 String)
(assert (= var3990!1 ""))
(assert true)
(define-const var3161 String (append/672562846 var3990!1 "Index: ")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Index: ") 
(declare-const var3990!2 String)
(assert (= var3990!2 (str.++ var3990!1 "Index: ")))
(assert true)
(define-const var1977 String (append/-1001720160 var3161 var1055)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var3161!1 String)
(assert (str.prefixof var3161 var3161!1))
(assert true)
(define-const var2989 String (append/672562846 var1977 ", Size: ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Size: ") 
(declare-const var1977!1 String)
(assert (= var1977!1 (str.++ var1977 ", Size: ")))
(define-const var3104 Int (mSize/1311397614 var3974)) ; Statement: $i2 = r0.<org.apache.dubbo.common.utils.Stack: int mSize> 
(assert true)
(define-const var248 String (append/-1001720160 var2989 var3104)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var2989!1 String)
(assert (str.prefixof var2989 var2989!1))
(assert true)
(define-const var2991 String (toString/-2075883882 var248)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1107025377 var1181 var2991)) ; Statement: specialinvoke $r1.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r7) 

(declare-const var1181!1 var420)
(declare-const var2991!1 String)
 ; Statement: throw $r1 
(check-sat)
; {mSize/1311397614=([org.apache.dubbo.common.utils.Stack], int), var420-init=([], java.lang.IndexOutOfBoundsException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1107025377=([java.lang.IndexOutOfBoundsException, java.lang.String], void)}
; {var3363=org.apache.dubbo.common.utils.Stack, var3974=r0, var1055=i0, var2242=$i1, var420=java.lang.IndexOutOfBoundsException, var1181=$r1, var3990=$r2, var3161=$r3, var1977=$r4, var2989=$r5, var3104=$i2, var248=$r6, var2991=$r7}
; {org.apache.dubbo.common.utils.Stack=var3363, r0=var3974, i0=var1055, $i1=var2242, java.lang.IndexOutOfBoundsException=var420, $r1=var1181, $r2=var3990, $r3=var3161, $r4=var1977, $r5=var2989, $i2=var3104, $r6=var248, $r7=var2991}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.Stack;	i0 := @parameter0: int;	$i1 = r0.<org.apache.dubbo.common.utils.Stack: int mSize>;	if i0 >= $i1 goto $r1 = new java.lang.IndexOutOfBoundsException;	$r1 = new java.lang.IndexOutOfBoundsException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Index: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Size: ");	$i2 = r0.<org.apache.dubbo.common.utils.Stack: int mSize>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r7);	throw $r1
;block_num 2