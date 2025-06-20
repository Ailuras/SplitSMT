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

(declare-sort var1330 0)
(declare-sort var1168 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1168_isContains/1628544859 (String Int) Bool)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2938 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2938 null-String)))
(declare-const var2506 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var2506 null-Int)))
(define-const var1829 Bool (var1168_isContains/1628544859 var2938 var2506)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isContains(java.lang.String,char)>(r0, c0) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (= (ite var1829 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3737 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var1168_isContains/1628544859=([java.lang.String, char], boolean)}
; {var2938=r0, var1330=null_type, var2506=c0, var1168=org.apache.dubbo.common.utils.StringUtils, var1829=$z0, var3737=$z1}
; {r0=var2938, null_type=var1330, c0=var2506, org.apache.dubbo.common.utils.StringUtils=var1168, $z0=var1829, $z1=var3737}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isContains(java.lang.String,char)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isContains(java.lang.String,char)>": 1}
;stmts r0 := @parameter0: java.lang.String;	c0 := @parameter1: char;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isContains(java.lang.String,char)>(r0, c0);	if $z0 != 0 goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 3