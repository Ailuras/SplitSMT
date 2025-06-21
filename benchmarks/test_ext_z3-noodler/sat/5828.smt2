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

(declare-sort var1618 0)
(declare-sort var633 0)
(declare-sort var595 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var1618 String) String)
(declare-fun var595_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-const null-var1618 var1618)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3301 var1618) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3301 null-var1618)))
(declare-const var2811 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2811 null-String)))
(declare-const var89 Int) ; Statement: i1 := @parameter1: int 
(assert (not (= var89 null-Int)))
(assert true)
(define-const var3111 String (getParameter/-1307325648 var3301 var2811)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2688 Bool (var595_isEmpty/-813097145 var3111)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2) 
(assert (= (ite var2688 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1494 Int (Int_parseInt/1370970945 var3111)) ; Statement: $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2) 
 ; Statement: return $i0 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var595_isEmpty/-813097145=([java.lang.String], boolean), Int_parseInt/1370970945=([java.lang.String], int)}
; {var1618=org.apache.dubbo.common.URL, var3301=r0, var2811=r1, var633=null_type, var89=i1, var3111=r2, var595=org.apache.dubbo.common.utils.StringUtils, var2688=$z0, var1494=$i0}
; {org.apache.dubbo.common.URL=var1618, r0=var3301, r1=var2811, null_type=var633, i1=var89, r2=var3111, org.apache.dubbo.common.utils.StringUtils=var595, $z0=var2688, $i0=var1494}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	i1 := @parameter1: int;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2);	$i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r2);	return $i0
;block_num 2