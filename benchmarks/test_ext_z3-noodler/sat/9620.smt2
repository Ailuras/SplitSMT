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

(declare-sort var3913 0)
(declare-sort var3656 0)
(declare-sort var2062 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPath/898047937 (var3913) String)
(declare-fun var3656_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getServiceInterface/-1311863806 (var3913) String)
(declare-const null-var3913 var3913)
(declare-const null-String String)
(declare-const var2236 var3913) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2236 null-var3913)))
(assert true)
(define-const var629 String (getPath/898047937 var2236)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(define-const var3222 Bool (var3656_isNotEmpty/-1251449450 var629)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert (= (ite var3222 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3061 String (getServiceInterface/-1311863806 var2236)) ; Statement: $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert true) ; Non Conditional
 ; Statement: if $r5 != null goto $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(assert (not (not (= var3061 null-String)))) ; Negate: Cond: $r5 != null  
 ; Statement: return null 
(check-sat)
; {getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), var3656_isNotEmpty/-1251449450=([java.lang.String], boolean), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String)}
; {var3913=org.apache.dubbo.common.URL, var2236=r0, var629=$r1, var3656=org.apache.dubbo.common.utils.StringUtils, var3222=$z0, var3061=$r5, var2062=null_type}
; {org.apache.dubbo.common.URL=var3913, r0=var2236, $r1=var629, org.apache.dubbo.common.utils.StringUtils=var3656, $z0=var3222, $r5=var3061, null_type=var2062}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$r5 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	if $r5 != null goto $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	return null
;block_num 4