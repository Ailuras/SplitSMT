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

(declare-sort var1361 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var2019 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2019 null-String)))
(assert true)
(define-const var3617 Int (length/-134980193 var2019)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var905 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var905 var3617)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>(int)>(i0) 

(declare-const var905!1 String)
(declare-const var3617!1 Int)
(define-const var3318 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto $r2 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var3318 var3617!1)) ; Cond: i2 >= i0 
(assert true)
(define-const var786 String (toString/-2075883882 var905!1)) ; Statement: $r2 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r2 
(check-sat)
; {length/-134980193=([java.lang.String], int), String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2019=r0, var1361=null_type, var3617=i0, var905=$r8, var3318=i2, var786=$r2}
; {r0=var2019, null_type=var1361, i0=var3617, $r8=var905, i2=var3318, $r2=var786}
;seq <java.lang.String: int length()>;	<java.lang.StringBuilder: void <init>(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.StringBuilder: void <init>(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int length()>();	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>(int)>(i0);	i2 = 0;	if i2 >= i0 goto $r2 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	$r2 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r2
;block_num 3