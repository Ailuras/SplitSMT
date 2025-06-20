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

(declare-sort var3323 0)
(declare-sort var413 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var413_max/1360571700 (Int Int) Int)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var413_min/-1112089438 (Int Int) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1549 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1549 null-String)))
(declare-const var2917 Int) ; Statement: c2 := @parameter1: char 
(assert (not (= var2917 null-Int)))
(declare-const var742 Int) ; Statement: i4 := @parameter2: int 
(assert (not (= var742 null-Int)))
(declare-const var2232 Int) ; Statement: i5 := @parameter3: int 
(assert (not (= var2232 null-Int)))
(define-const var1443 Int (var413_max/1360571700 var742 0)) ; Statement: i6 = staticinvoke <java.lang.Math: int max(int,int)>(i4, 0) 
(assert true)
(define-const var3151 Int (length/-134980193 var1549)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var3307 Int (- var3151 1)) ; Statement: $i1 = $i0 - 1 
(define-const var1350 Int (var413_min/-1112089438 var2232 var3307)) ; Statement: i7 = staticinvoke <java.lang.Math: int min(int,int)>(i5, $i1) 
 ; Statement: if i6 <= i7 goto i8 = i7 
(assert (not (<= var1443 var1350))) ; Negate: Cond: i6 <= i7  
(define-const var809 Int (cast-from-Int-to-Int -1)) ; Statement: $i10 = (int) -1 
 ; Statement: return $i10 
(check-sat)
; {var413_max/1360571700=([int, int], int), length/-134980193=([java.lang.String], int), var413_min/-1112089438=([int, int], int), cast-from-Int-to-Int=([int], int)}
; {var1549=r0, var3323=null_type, var2917=c2, var742=i4, var2232=i5, var413=java.lang.Math, var1443=i6, var3151=$i0, var3307=$i1, var1350=i7, var809=$i10}
; {r0=var1549, null_type=var3323, c2=var2917, i4=var742, i5=var2232, java.lang.Math=var413, i6=var1443, $i0=var3151, $i1=var3307, i7=var1350, $i10=var809}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r0 := @parameter0: java.lang.String;	c2 := @parameter1: char;	i4 := @parameter2: int;	i5 := @parameter3: int;	i6 = staticinvoke <java.lang.Math: int max(int,int)>(i4, 0);	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = $i0 - 1;	i7 = staticinvoke <java.lang.Math: int min(int,int)>(i5, $i1);	if i6 <= i7 goto i8 = i7;	$i10 = (int) -1;	return $i10
;block_num 2