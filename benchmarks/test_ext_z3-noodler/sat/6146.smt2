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

(declare-sort var3134 0)
(declare-sort var3661 0)
(declare-sort var3881 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var3881) String)
(declare-fun cast-from-var3661-to-var3881 (var3661) var3881)
(declare-fun setAccesslog/-1953353007 (var3134 String) void)
(declare-const null-var3134 var3134)
(declare-const null-var3661 var3661)
(declare-const var1912 var3134) ; Statement: r1 := @this: org.apache.dubbo.config.AbstractServiceConfig 
(assert (not (= var1912 null-var3134)))
(declare-const var3760 var3661) ; Statement: r0 := @parameter0: java.lang.Boolean 
(assert (not (= var3760 null-var3661)))
 ; Statement: if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var3760 null-var3661))) ; Cond: r0 != null 
(define-const var2204 String (String_valueOf/-333372740 (cast-from-var3661-to-var3881 var3760))) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
;(assert (setAccesslog/-1953353007 var1912 var2204)) ; Statement: virtualinvoke r1.<org.apache.dubbo.config.AbstractServiceConfig: void setAccesslog(java.lang.String)>($r2) 

(declare-const var1912!1 var3134)
(declare-const var2204!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var3661-to-var3881=([java.lang.Boolean], java.lang.Object), setAccesslog/-1953353007=([org.apache.dubbo.config.AbstractServiceConfig, java.lang.String], void)}
; {var3134=org.apache.dubbo.config.AbstractServiceConfig, var1912=r1, var3661=java.lang.Boolean, var3760=r0, var3881=java.lang.Object, var2204=$r2}
; {org.apache.dubbo.config.AbstractServiceConfig=var3134, r1=var1912, java.lang.Boolean=var3661, r0=var3760, java.lang.Object=var3881, $r2=var2204}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.AbstractServiceConfig;	r0 := @parameter0: java.lang.Boolean;	if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	virtualinvoke r1.<org.apache.dubbo.config.AbstractServiceConfig: void setAccesslog(java.lang.String)>($r2);	return
;block_num 3