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

(declare-sort var1164 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1164-init () var1164)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1107025377 (var1164 String) void)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const null-Int Int)
(declare-const var1002 (Array Int Int)) ; Statement: r0 := @parameter0: byte[] 
(assert (not (= var1002 null-__Array__Int__Int__)))
(declare-const var351 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var351 null-Int)))
(declare-const var1787 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var1787 null-Int)))
 ; Statement: if i0 >= 0 goto (branch) 
(assert (not (>= var351 0))) ; Negate: Cond: i0 >= 0  
(define-const var723 var1164 var1164-init) ; Statement: $r17 = new java.lang.IndexOutOfBoundsException 
(define-const var3455 String String-init) ; Statement: $r16 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3455)) ; Statement: specialinvoke $r16.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3455!1 String)
(assert (= var3455!1 ""))
(assert true)
(define-const var2267 String (append/672562846 var3455!1 "bytes2hex: offset < 0, offset is ")) ; Statement: $r13 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("bytes2hex: offset < 0, offset is ") 
(declare-const var3455!2 String)
(assert (= var3455!2 (str.++ var3455!1 "bytes2hex: offset < 0, offset is ")))
(assert true)
(define-const var1739 String (append/-1001720160 var2267 var351)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var2267!1 String)
(assert (str.prefixof var2267 var2267!1))
(assert true)
(define-const var3568 String (toString/-2075883882 var1739)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1107025377 var723 var3568)) ; Statement: specialinvoke $r17.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r15) 

(declare-const var723!1 var1164)
(declare-const var3568!1 String)
 ; Statement: throw $r17 
(check-sat)
; {var1164-init=([], java.lang.IndexOutOfBoundsException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1107025377=([java.lang.IndexOutOfBoundsException, java.lang.String], void)}
; {var1002=r0, var351=i0, var1787=i1, var1164=java.lang.IndexOutOfBoundsException, var723=$r17, var3455=$r16, var2267=$r13, var1739=$r14, var3568=$r15}
; {r0=var1002, i0=var351, i1=var1787, java.lang.IndexOutOfBoundsException=var1164, $r17=var723, $r16=var3455, $r13=var2267, $r14=var1739, $r15=var3568}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: byte[];	i0 := @parameter1: int;	i1 := @parameter2: int;	if i0 >= 0 goto (branch);	$r17 = new java.lang.IndexOutOfBoundsException;	$r16 = new java.lang.StringBuilder;	specialinvoke $r16.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("bytes2hex: offset < 0, offset is ");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r17.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r15);	throw $r17
;block_num 2