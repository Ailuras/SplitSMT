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

(declare-sort var3235 0)
(declare-sort var3624 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getLength-Arr-var3235-1 ((Array Int var3235)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-__Array__Int__var3235__ (Array Int var3235))
(declare-const null-String String)
(declare-const var2747 (Array Int var3235)) ; Statement: r1 := @parameter0: java.lang.Object[] 
(assert (not (= var2747 null-__Array__Int__var3235__)))
(declare-const var3042 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var3042 null-String)))
(define-const var152 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var152)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var152!1 String)
(assert (= var152!1 ""))
(define-const var1948 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
(define-const var1692 Int (getLength-Arr-var3235-1 var2747)) ; Statement: $i0 = lengthof r1 
 ; Statement: if i3 >= $i0 goto $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var1948 var1692)) ; Cond: i3 >= $i0 
(assert true)
(define-const var678 String (toString/-2075883882 var152!1)) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r2 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getLength-Arr-var3235-1=([java.lang.Object[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3235=java.lang.Object, var2747=r1, var3042=r5, var3624=null_type, var152=$r0, var1948=i3, var1692=$i0, var678=$r2}
; {java.lang.Object=var3235, r1=var2747, r5=var3042, null_type=var3624, $r0=var152, i3=var1948, $i0=var1692, $r2=var678}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.Object[];	r5 := @parameter1: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	i3 = 0;	$i0 = lengthof r1;	if i3 >= $i0 goto $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r2
;block_num 3