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

(declare-sort var3616 0)
(declare-sort var3252 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mSize/1311397614 (var3616) Int)
(declare-fun var3252-init () var3252)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1107025377 (var3252 String) void)
(declare-const null-var3616 var3616)
(declare-const null-Int Int)
(declare-const var449 var3616) ; Statement: r0 := @this: org.apache.dubbo.common.utils.Stack 
(assert (not (= var449 null-var3616)))
(declare-const var3253 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3253 null-Int)))
(define-const var1924 Int (mSize/1311397614 var449)) ; Statement: $i1 = r0.<org.apache.dubbo.common.utils.Stack: int mSize> 
 ; Statement: if i0 >= $i1 goto $r1 = new java.lang.IndexOutOfBoundsException 
(assert (>= var3253 var1924)) ; Cond: i0 >= $i1 
(define-const var1716 var3252 var3252-init) ; Statement: $r1 = new java.lang.IndexOutOfBoundsException 
(define-const var130 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var130)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var130!1 String)
(assert (= var130!1 ""))
(assert true)
(define-const var794 String (append/672562846 var130!1 "Index: ")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Index: ") 
(declare-const var130!2 String)
(assert (= var130!2 (str.++ var130!1 "Index: ")))
(assert true)
(define-const var2825 String (append/-1001720160 var794 var3253)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var794!1 String)
(assert (str.prefixof var794 var794!1))
(assert true)
(define-const var2238 String (append/672562846 var2825 ", Size: ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Size: ") 
(declare-const var2825!1 String)
(assert (= var2825!1 (str.++ var2825 ", Size: ")))
(define-const var2509 Int (mSize/1311397614 var449)) ; Statement: $i2 = r0.<org.apache.dubbo.common.utils.Stack: int mSize> 
(assert true)
(define-const var1917 String (append/-1001720160 var2238 var2509)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2) 
(declare-const var2238!1 String)
(assert (str.prefixof var2238 var2238!1))
(assert true)
(define-const var2355 String (toString/-2075883882 var1917)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1107025377 var1716 var2355)) ; Statement: specialinvoke $r1.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r7) 

(declare-const var1716!1 var3252)
(declare-const var2355!1 String)
 ; Statement: throw $r1 
(check-sat)
; {mSize/1311397614=([org.apache.dubbo.common.utils.Stack], int), var3252-init=([], java.lang.IndexOutOfBoundsException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1107025377=([java.lang.IndexOutOfBoundsException, java.lang.String], void)}
; {var3616=org.apache.dubbo.common.utils.Stack, var449=r0, var3253=i0, var1924=$i1, var3252=java.lang.IndexOutOfBoundsException, var1716=$r1, var130=$r2, var794=$r3, var2825=$r4, var2238=$r5, var2509=$i2, var1917=$r6, var2355=$r7}
; {org.apache.dubbo.common.utils.Stack=var3616, r0=var449, i0=var3253, $i1=var1924, java.lang.IndexOutOfBoundsException=var3252, $r1=var1716, $r2=var130, $r3=var794, $r4=var2825, $r5=var2238, $i2=var2509, $r6=var1917, $r7=var2355}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.Stack;	i0 := @parameter0: int;	$i1 = r0.<org.apache.dubbo.common.utils.Stack: int mSize>;	if i0 >= $i1 goto $r1 = new java.lang.IndexOutOfBoundsException;	$r1 = new java.lang.IndexOutOfBoundsException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Index: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", Size: ");	$i2 = r0.<org.apache.dubbo.common.utils.Stack: int mSize>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i2);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r7);	throw $r1
;block_num 2