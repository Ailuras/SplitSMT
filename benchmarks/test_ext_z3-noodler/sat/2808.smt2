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

(declare-sort var3901 0)
(declare-sort var3055 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(declare-fun var3055_isUpperCase/-385658622 (Int) Bool)
(declare-const null-String String)
(declare-const var723 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var723 null-String)))
(assert (and true (and (> (str.len var723) 0) (<= 0 0))))
(define-const var3244 Int (charAt/698050440 var723 0)) ; Statement: $c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0) 
(define-const var661 Bool (var3055_isUpperCase/-385658622 var3244)) ; Statement: $z0 = staticinvoke <java.lang.Character: boolean isUpperCase(char)>($c0) 
 ; Statement: return $z0 
(check-sat)
; {charAt/698050440=([java.lang.String, int], char), var3055_isUpperCase/-385658622=([char], boolean)}
; {var723=r0, var3901=null_type, var3244=$c0, var3055=java.lang.Character, var661=$z0}
; {r0=var723, null_type=var3901, $c0=var3244, java.lang.Character=var3055, $z0=var661}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$c0 = virtualinvoke r0.<java.lang.String: char charAt(int)>(0);	$z0 = staticinvoke <java.lang.Character: boolean isUpperCase(char)>($c0);	return $z0
;block_num 1