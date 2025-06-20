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

(declare-sort var2921 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2921-init () var2921)
(declare-fun <init>/1568434105 (var2921 Int) void)
(declare-const null-Int Int)
(declare-const var2981 Int) ; Statement: $c0 := @parameter0: char 
(assert (not (= var2981 null-Int)))
(define-const var137 var2921 var2921-init) ; Statement: $r0 = new org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298 
(assert true)
;(assert (<init>/1568434105 var137 var2981)) ; Statement: specialinvoke $r0.<org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298: void <init>(char)>($c0) 

(declare-const var137!1 var2921)
(declare-const var2981!1 Int)
 ; Statement: return $r0 
(check-sat)
; {var2921-init=([], org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298), <init>/1568434105=([org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298, char], void)}
; {var2981=$c0, var2921=org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298, var137=$r0}
; {$c0=var2981, org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298=var2921, $r0=var137}
;seq <org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298: void <init>(char)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298: void <init>(char)>": 1}
;stmts $c0 := @parameter0: char;	$r0 = new org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298;	specialinvoke $r0.<org.apache.dubbo.common.utils.StringUtils$lambda_isSplitCase_0__298: void <init>(char)>($c0);	return $r0
;block_num 1