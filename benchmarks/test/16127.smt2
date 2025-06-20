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

(declare-sort var2487 0)
(declare-sort var1401 0)
(declare-sort var3126 0)
(declare-sort var3382 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var1401 String) String)
(declare-fun var3382_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2487 var2487)
(declare-const null-String String)
(declare-const null-var1401 var1401)
(declare-const var547 var2487) ; Statement: r6 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var547 null-var2487)))
(declare-const var2040 String) ; Statement: r3 := @parameter0: java.lang.StringBuilder 
(assert (not (= var2040 null-String)))
(declare-const var2702 var1401) ; Statement: r0 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var2702 null-var1401)))
(declare-const var649 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var649 null-String)))
(assert true)
(define-const var3541 String (getParameter/-1307325648 var2702 var649)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var2220 Bool (var3382_isBlank/-523695098 (cast-from-String-to-String var3541))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r2) 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var2220 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3382_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2487=org.apache.dubbo.registry.nacos.NacosRegistry, var547=r6, var2040=r3, var1401=org.apache.dubbo.common.URL, var2702=r0, var649=r1, var3126=null_type, var3541=r2, var3382=org.apache.dubbo.common.utils.StringUtils, var2220=$z0}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var2487, r6=var547, r3=var2040, org.apache.dubbo.common.URL=var1401, r0=var2702, r1=var649, null_type=var3126, r2=var3541, org.apache.dubbo.common.utils.StringUtils=var3382, $z0=var2220}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r6 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r3 := @parameter0: java.lang.StringBuilder;	r0 := @parameter1: org.apache.dubbo.common.URL;	r1 := @parameter2: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r2);	if $z0 != 0 goto return;	return
;block_num 2