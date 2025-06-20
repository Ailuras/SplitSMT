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

(declare-sort var2068 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2068-init () var2068)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1107025377 (var2068 String) void)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const null-Int Int)
(declare-const var592 (Array Int Int)) ; Statement: r0 := @parameter0: byte[] 
(assert (not (= var592 null-__Array__Int__Int__)))
(declare-const var1210 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var1210 null-Int)))
(declare-const var842 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var842 null-Int)))
(declare-const var2372 (Array Int Int)) ; Statement: r1 := @parameter3: char[] 
(assert (not (= var2372 null-__Array__Int__Int__)))
 ; Statement: if i0 >= 0 goto (branch) 
(assert (not (>= var1210 0))) ; Negate: Cond: i0 >= 0  
(define-const var2422 var2068 var2068-init) ; Statement: $r17 = new java.lang.IndexOutOfBoundsException 
(define-const var637 String String-init) ; Statement: $r16 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var637)) ; Statement: specialinvoke $r16.<java.lang.StringBuilder: void <init>()>() 
(declare-const var637!1 String)
(assert (= var637!1 ""))
(assert true)
(define-const var2480 String (append/672562846 var637!1 "bytes2base64: offset < 0, offset is ")) ; Statement: $r11 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("bytes2base64: offset < 0, offset is ") 
(declare-const var637!2 String)
(assert (= var637!2 (str.++ var637!1 "bytes2base64: offset < 0, offset is ")))
(assert true)
(define-const var2862 String (append/-1001720160 var2480 var1210)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var2480!1 String)
(assert (str.prefixof var2480 var2480!1))
(assert true)
(define-const var2483 String (toString/-2075883882 var2862)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1107025377 var2422 var2483)) ; Statement: specialinvoke $r17.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r13) 

(declare-const var2422!1 var2068)
(declare-const var2483!1 String)
 ; Statement: throw $r17 
(check-sat)
; {var2068-init=([], java.lang.IndexOutOfBoundsException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1107025377=([java.lang.IndexOutOfBoundsException, java.lang.String], void)}
; {var592=r0, var1210=i0, var842=i1, var2372=r1, var2068=java.lang.IndexOutOfBoundsException, var2422=$r17, var637=$r16, var2480=$r11, var2862=$r12, var2483=$r13}
; {r0=var592, i0=var1210, i1=var842, r1=var2372, java.lang.IndexOutOfBoundsException=var2068, $r17=var2422, $r16=var637, $r11=var2480, $r12=var2862, $r13=var2483}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: byte[];	i0 := @parameter1: int;	i1 := @parameter2: int;	r1 := @parameter3: char[];	if i0 >= 0 goto (branch);	$r17 = new java.lang.IndexOutOfBoundsException;	$r16 = new java.lang.StringBuilder;	specialinvoke $r16.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("bytes2base64: offset < 0, offset is ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r17.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r13);	throw $r17
;block_num 2