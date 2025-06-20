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

(declare-sort var2585 0)
(declare-sort var1159 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1159-init () var1159)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1107025377 (var1159 String) void)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3471 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3471 null-String)))
(declare-const var506 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var506 null-Int)))
(declare-const var3297 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var3297 null-Int)))
(declare-const var531 String) ; Statement: r1 := @parameter3: java.lang.String 
(assert (not (= var531 null-String)))
 ; Statement: if i0 >= 0 goto (branch) 
(assert (not (>= var506 0))) ; Negate: Cond: i0 >= 0  
(define-const var372 var1159 var1159-init) ; Statement: $r20 = new java.lang.IndexOutOfBoundsException 
(define-const var1302 String String-init) ; Statement: $r19 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1302)) ; Statement: specialinvoke $r19.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1302!1 String)
(assert (= var1302!1 ""))
(assert true)
(define-const var2917 String (append/672562846 var1302!1 "base642bytes: offset < 0, offset is ")) ; Statement: $r14 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("base642bytes: offset < 0, offset is ") 
(declare-const var1302!2 String)
(assert (= var1302!2 (str.++ var1302!1 "base642bytes: offset < 0, offset is ")))
(assert true)
(define-const var908 String (append/-1001720160 var2917 var506)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var2917!1 String)
(assert (str.prefixof var2917 var2917!1))
(assert true)
(define-const var2640 String (toString/-2075883882 var908)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1107025377 var372 var2640)) ; Statement: specialinvoke $r20.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r16) 

(declare-const var372!1 var1159)
(declare-const var2640!1 String)
 ; Statement: throw $r20 
(check-sat)
; {var1159-init=([], java.lang.IndexOutOfBoundsException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1107025377=([java.lang.IndexOutOfBoundsException, java.lang.String], void)}
; {var3471=r0, var2585=null_type, var506=i0, var3297=i1, var531=r1, var1159=java.lang.IndexOutOfBoundsException, var372=$r20, var1302=$r19, var2917=$r14, var908=$r15, var2640=$r16}
; {r0=var3471, null_type=var2585, i0=var506, i1=var3297, r1=var531, java.lang.IndexOutOfBoundsException=var1159, $r20=var372, $r19=var1302, $r14=var2917, $r15=var908, $r16=var2640}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 := @parameter1: int;	i1 := @parameter2: int;	r1 := @parameter3: java.lang.String;	if i0 >= 0 goto (branch);	$r20 = new java.lang.IndexOutOfBoundsException;	$r19 = new java.lang.StringBuilder;	specialinvoke $r19.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("base642bytes: offset < 0, offset is ");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r20.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r16);	throw $r20
;block_num 2