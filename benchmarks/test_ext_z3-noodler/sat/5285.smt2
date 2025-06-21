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

(declare-sort var1000 0)
(declare-sort var138 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var138_isContains/1628544859 (String Int) Bool)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2292 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2292 null-String)))
(declare-const var2385 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var2385 null-Int)))
(define-const var2843 Bool (var138_isContains/1628544859 var2292 var2385)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isContains(java.lang.String,char)>(r0, c0) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (not (= (ite var2843 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1434 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= return $z1] 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var138_isContains/1628544859=([java.lang.String, char], boolean)}
; {var2292=r0, var1000=null_type, var2385=c0, var138=org.apache.dubbo.common.utils.StringUtils, var2843=$z0, var1434=$z1}
; {r0=var2292, null_type=var1000, c0=var2385, org.apache.dubbo.common.utils.StringUtils=var138, $z0=var2843, $z1=var1434}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isContains(java.lang.String,char)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isContains(java.lang.String,char)>": 1}
;stmts r0 := @parameter0: java.lang.String;	c0 := @parameter1: char;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isContains(java.lang.String,char)>(r0, c0);	if $z0 != 0 goto $z1 = 0;	$z1 = 1;	goto [?= return $z1];	return $z1
;block_num 3