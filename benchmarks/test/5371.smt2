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

(declare-sort var355 0)
(declare-sort var1330 0)
(declare-sort var3360 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var3360) String)
(declare-fun cast-from-var1330-to-var3360 (var1330) var3360)
(declare-fun setToken/1750616856 (var355 String) void)
(declare-const null-var355 var355)
(declare-const null-var1330 var1330)
(declare-const var2669 var355) ; Statement: r1 := @this: org.apache.dubbo.config.AbstractServiceConfig 
(assert (not (= var2669 null-var355)))
(declare-const var1936 var1330) ; Statement: r0 := @parameter0: java.lang.Boolean 
(assert (not (= var1936 null-var1330)))
 ; Statement: if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var1936 null-var1330))) ; Cond: r0 != null 
(define-const var2541 String (String_valueOf/-333372740 (cast-from-var1330-to-var3360 var1936))) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
;(assert (setToken/1750616856 var2669 var2541)) ; Statement: virtualinvoke r1.<org.apache.dubbo.config.AbstractServiceConfig: void setToken(java.lang.String)>($r2) 

(declare-const var2669!1 var355)
(declare-const var2541!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var1330-to-var3360=([java.lang.Boolean], java.lang.Object), setToken/1750616856=([org.apache.dubbo.config.AbstractServiceConfig, java.lang.String], void)}
; {var355=org.apache.dubbo.config.AbstractServiceConfig, var2669=r1, var1330=java.lang.Boolean, var1936=r0, var3360=java.lang.Object, var2541=$r2}
; {org.apache.dubbo.config.AbstractServiceConfig=var355, r1=var2669, java.lang.Boolean=var1330, r0=var1936, java.lang.Object=var3360, $r2=var2541}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.AbstractServiceConfig;	r0 := @parameter0: java.lang.Boolean;	if r0 != null goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	virtualinvoke r1.<org.apache.dubbo.config.AbstractServiceConfig: void setToken(java.lang.String)>($r2);	return
;block_num 3