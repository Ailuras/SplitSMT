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

(declare-sort var1160 0)
(declare-sort var2417 0)
(declare-sort var2509 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun registryUrl/131801897 (var1160) var2417)
(declare-fun getParameter/-1307325648 (var2417 String) String)
(declare-fun var2509_isEmpty/-813097145 (String) Bool)
(declare-const null-var1160 var1160)
(declare-const null-var2417 var2417)
(declare-const var93 var1160) ; Statement: r0 := @this: org.apache.dubbo.registry.support.AbstractRegistry 
(assert (not (= var93 null-var1160)))
(declare-const var776 var2417) ; Statement: r19 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var776 null-var2417)))
(define-const var2971 var2417 (registryUrl/131801897 var93)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.support.AbstractRegistry: org.apache.dubbo.common.URL registryUrl> 
(assert true)
(define-const var2839 String (getParameter/-1307325648 var2971 "accepts")) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("accepts") 
(define-const var3769 Bool (var2509_isEmpty/-813097145 var2839)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert (not (= (ite var3769 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 1 
(check-sat)
; {registryUrl/131801897=([org.apache.dubbo.registry.support.AbstractRegistry], org.apache.dubbo.common.URL), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2509_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1160=org.apache.dubbo.registry.support.AbstractRegistry, var93=r0, var2417=org.apache.dubbo.common.URL, var776=r19, var2971=$r1, var2839=r2, var2509=org.apache.dubbo.common.utils.StringUtils, var3769=$z0}
; {org.apache.dubbo.registry.support.AbstractRegistry=var1160, r0=var93, org.apache.dubbo.common.URL=var2417, r19=var776, $r1=var2971, r2=var2839, org.apache.dubbo.common.utils.StringUtils=var2509, $z0=var3769}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.support.AbstractRegistry;	r19 := @parameter0: org.apache.dubbo.common.URL;	$r1 = r0.<org.apache.dubbo.registry.support.AbstractRegistry: org.apache.dubbo.common.URL registryUrl>;	r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("accepts");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	return 1
;block_num 2