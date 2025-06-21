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

(declare-sort var2209 0)
(declare-sort var12 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var12-init () var12)
(declare-fun <init>/-325640736 (var12) void)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var927 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var927 null-String)))
(declare-const var3125 Int) ; Statement: c1 := @parameter1: char 
(assert (not (= var3125 null-Int)))
(define-const var1562 var12 var12-init) ; Statement: $r4 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1562)) ; Statement: specialinvoke $r4.<java.util.ArrayList: void <init>()>() 

(declare-const var1562!1 var12)
(define-const var2362 Int 0) ; Statement: i3 = 0 
(assert true)
(define-const var2915 Int (length/-134980193 var927)) ; Statement: i0 = virtualinvoke r1.<java.lang.String: int length()>() 
(define-const var2488 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i0 goto (branch) 
(assert (>= var2488 var2915)) ; Cond: i4 >= i0 
 ; Statement: if i3 < 0 goto return $r4 
(assert (< var2362 0)) ; Cond: i3 < 0 
 ; Statement: return $r4 
(check-sat)
; {var12-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), length/-134980193=([java.lang.String], int)}
; {var927=r1, var2209=null_type, var3125=c1, var12=java.util.ArrayList, var1562=$r4, var2362=i3, var2915=i0, var2488=i4}
; {r1=var927, null_type=var2209, c1=var3125, java.util.ArrayList=var12, $r4=var1562, i3=var2362, i0=var2915, i4=var2488}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r1 := @parameter0: java.lang.String;	c1 := @parameter1: char;	$r4 = new java.util.ArrayList;	specialinvoke $r4.<java.util.ArrayList: void <init>()>();	i3 = 0;	i0 = virtualinvoke r1.<java.lang.String: int length()>();	i4 = 0;	if i4 >= i0 goto (branch);	if i3 < 0 goto return $r4;	return $r4
;block_num 4