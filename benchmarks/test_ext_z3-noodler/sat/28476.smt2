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

(declare-sort var2831 0)
(declare-sort var1997 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1997_lambda$isWord$1/1396840434 (Int) Bool)
(declare-const null-var2831 var2831)
(declare-const null-Int Int)
(declare-const var3285 var2831) ; Statement: $r0 := @this: org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299 
(assert (not (= var3285 null-var2831)))
(declare-const var1248 Int) ; Statement: $i0 := @parameter0: int 
(assert (not (= var1248 null-Int)))
(define-const var998 Bool (var1997_lambda$isWord$1/1396840434 var1248)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean lambda$isWord$1(int)>($i0) 
 ; Statement: return $z0 
(check-sat)
; {var1997_lambda$isWord$1/1396840434=([int], boolean)}
; {var2831=org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299, var3285=$r0, var1248=$i0, var1997=org.apache.dubbo.common.utils.StringUtils, var998=$z0}
; {org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299=var2831, $r0=var3285, $i0=var1248, org.apache.dubbo.common.utils.StringUtils=var1997, $z0=var998}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean lambda$isWord$1(int)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean lambda$isWord$1(int)>": 1}
;stmts $r0 := @this: org.apache.dubbo.common.utils.StringUtils$lambda_isWord_1__299;	$i0 := @parameter0: int;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean lambda$isWord$1(int)>($i0);	return $z0
;block_num 1