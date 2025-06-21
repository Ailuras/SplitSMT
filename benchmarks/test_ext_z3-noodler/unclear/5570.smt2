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

(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-Int-to-Float32 (Int) Float32)
(declare-fun cast-from-Float32-to-Int (Float32) Int)
(declare-const null-Int Int)
(declare-const var3953 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3953 null-Int)))
 ; Statement: if i0 >= 3 goto (branch) 
(assert (>= var3953 3)) ; Cond: i0 >= 3 
 ; Statement: if i0 >= 1073741824 goto return 2147483647 
(assert (not (>= var3953 1073741824))) ; Negate: Cond: i0 >= 1073741824  
(define-const var3332 Float32 (cast-from-Int-to-Float32 var3953)) ; Statement: $f0 = (float) i0 
(define-const var593 Float32 (fp.div roundNearestTiesToEven var3332 ((_ to_fp 8 24) #x3f400000))) ; Statement: $f1 = $f0 / 0.75F 
(define-const var566 Float32 (fp.add roundNearestTiesToEven var593 ((_ to_fp 8 24) #x3f800000))) ; Statement: $f2 = $f1 + 1.0F 
(define-const var797 Int (cast-from-Float32-to-Int var566)) ; Statement: $i1 = (int) $f2 
 ; Statement: return $i1 
(check-sat)
; {cast-from-Int-to-Float32=([int], float), cast-from-Float32-to-Int=([float], int)}
; {var3953=i0, var3332=$f0, var593=$f1, var566=$f2, var797=$i1}
; {i0=var3953, $f0=var3332, $f1=var593, $f2=var566, $i1=var797}
;seq 
;cnt {}
;stmts i0 := @parameter0: int;	if i0 >= 3 goto (branch);	if i0 >= 1073741824 goto return 2147483647;	$f0 = (float) i0;	$f1 = $f0 / 0.75F;	$f2 = $f1 + 1.0F;	$i1 = (int) $f2;	return $i1
;block_num 3