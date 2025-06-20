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

(declare-sort var1396 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun toCharArray/415275702 (String) (Array Int Int))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1801 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1801 null-String)))
(declare-const var1307 Int) ; Statement: i2 := @parameter1: int 
(assert (not (= var1307 null-Int)))
(define-const var1908 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1908)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1908!1 String)
(assert (= var1908!1 ""))
(assert true)
(define-const var3805 (Array Int Int) (toCharArray/415275702 var1801)) ; Statement: r2 = virtualinvoke r1.<java.lang.String: char[] toCharArray()>() 
(define-const var2096 Int 0) ; Statement: i3 = 0 
(define-const var1261 Int (getLength-Arr-Int-1 var3805)) ; Statement: i0 = lengthof r2 
(define-const var488 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i0 goto $r3 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var488 var1261)) ; Cond: i4 >= i0 
(assert true)
(define-const var288 String (toString/-2075883882 var1908!1)) ; Statement: $r3 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), toCharArray/415275702=([java.lang.String], char[]), getLength-Arr-Int-1=([char[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1801=r1, var1396=null_type, var1307=i2, var1908=$r4, var3805=r2, var2096=i3, var1261=i0, var488=i4, var288=$r3}
; {r1=var1801, null_type=var1396, i2=var1307, $r4=var1908, r2=var3805, i3=var2096, i0=var1261, i4=var488, $r3=var288}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: char[] toCharArray()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: char[] toCharArray()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.String;	i2 := @parameter1: int;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: char[] toCharArray()>();	i3 = 0;	i0 = lengthof r2;	i4 = 0;	if i4 >= i0 goto $r3 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	$r3 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 3