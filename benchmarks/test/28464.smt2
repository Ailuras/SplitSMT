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

(declare-sort var1140 0)
(declare-sort var583 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cap0/1245669850 (var1140) Int)
(declare-fun var583_lambda$isSplitCase$0/875884447 (Int Int) Bool)
(declare-const null-var1140 var1140)
(declare-const null-Int Int)
(declare-const var1476 var1140) ; Statement: $r0 := @this: org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298 
(assert (not (= var1476 null-var1140)))
(declare-const var3769 Int) ; Statement: $i0 := @parameter0: int 
(assert (not (= var3769 null-Int)))
(define-const var1088 Int (cap0/1245669850 var1476)) ; Statement: $c1 = $r0.<org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298: char cap0> 
(define-const var1280 Bool (var583_lambda$isSplitCase$0/875884447 var1088 var3769)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean lambda$isSplitCase$0(char,int)>($c1, $i0) 
 ; Statement: return $z0 
(check-sat)
; {cap0/1245669850=([org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298], char), var583_lambda$isSplitCase$0/875884447=([char, int], boolean)}
; {var1140=org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298, var1476=$r0, var3769=$i0, var1088=$c1, var583=org.apache.dubbo.common.utils.StringUtils, var1280=$z0}
; {org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298=var1140, $r0=var1476, $i0=var3769, $c1=var1088, org.apache.dubbo.common.utils.StringUtils=var583, $z0=var1280}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean lambda$isSplitCase$0(char,int)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean lambda$isSplitCase$0(char,int)>": 1}
;stmts $r0 := @this: org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298;	$i0 := @parameter0: int;	$c1 = $r0.<org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298: char cap0>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean lambda$isSplitCase$0(char,int)>($c1, $i0);	return $z0
;block_num 1