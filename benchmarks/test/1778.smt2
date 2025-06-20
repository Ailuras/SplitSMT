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

(declare-sort var2319 0)
(declare-sort var2759 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2759_max/1360571700 (Int Int) Int)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var2759_min/-1112089438 (Int Int) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3033 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3033 null-String)))
(declare-const var1931 Int) ; Statement: c1 := @parameter1: char 
(assert (not (= var1931 null-Int)))
(declare-const var1538 Int) ; Statement: i3 := @parameter2: int 
(assert (not (= var1538 null-Int)))
(declare-const var2885 Int) ; Statement: i4 := @parameter3: int 
(assert (not (= var2885 null-Int)))
(define-const var3005 Int (var2759_max/1360571700 var1538 0)) ; Statement: i5 = staticinvoke <java.lang.Math: int max(int,int)>(i3, 0) 
(assert true)
(define-const var561 Int (length/-134980193 var3033)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var3296 Int (var2759_min/-1112089438 var2885 var561)) ; Statement: i6 = staticinvoke <java.lang.Math: int min(int,int)>(i4, $i0) 
 ; Statement: if i5 <= i6 goto i7 = i5 
(assert (not (<= var3005 var3296))) ; Negate: Cond: i5 <= i6  
(define-const var3826 Int (cast-from-Int-to-Int -1)) ; Statement: $i9 = (int) -1 
 ; Statement: return $i9 
(check-sat)
; {var2759_max/1360571700=([int, int], int), length/-134980193=([java.lang.String], int), var2759_min/-1112089438=([int, int], int), cast-from-Int-to-Int=([int], int)}
; {var3033=r0, var2319=null_type, var1931=c1, var1538=i3, var2885=i4, var2759=java.lang.Math, var3005=i5, var561=$i0, var3296=i6, var3826=$i9}
; {r0=var3033, null_type=var2319, c1=var1931, i3=var1538, i4=var2885, java.lang.Math=var2759, i5=var3005, $i0=var561, i6=var3296, $i9=var3826}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @parameter0: java.lang.String;	c1 := @parameter1: char;	i3 := @parameter2: int;	i4 := @parameter3: int;	i5 = staticinvoke <java.lang.Math: int max(int,int)>(i3, 0);	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	i6 = staticinvoke <java.lang.Math: int min(int,int)>(i4, $i0);	if i5 <= i6 goto i7 = i5;	$i9 = (int) -1;	return $i9
;block_num 2