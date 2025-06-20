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

(declare-sort var2524 0)
(declare-sort var319 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/-1061048412 ((s String)) String s)
(declare-fun appendIfPresent/-1232314620 (var2524 String var319 String) void)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2524 var2524)
(declare-const null-var319 var319)
(declare-const var2467 var2524) ; Statement: r1 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var2467 null-var2524)))
(declare-const var230 var319) ; Statement: r2 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var230 null-var319)))
(define-const var1084 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/-1061048412 var1084 "providers")) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("providers") 
(declare-const var1084!1 String)
(assert (= var1084!1 "providers"))
(assert true)
;(assert (appendIfPresent/-1232314620 var2467 var1084!1 var230 "interface")) ; Statement: specialinvoke r1.<org.apache.dubbo.registry.nacos.NacosRegistry: void appendIfPresent(java.lang.StringBuilder,org.apache.dubbo.common.URL,java.lang.String)>($r0, r2, "interface") 

(declare-const var2467!1 var2524)
(declare-const var1084!2 String)
(declare-const var230!1 var319)
(declare-const var567 String)
(assert true)
;(assert (appendIfPresent/-1232314620 var2467!1 var1084!2 var230!1 "version")) ; Statement: specialinvoke r1.<org.apache.dubbo.registry.nacos.NacosRegistry: void appendIfPresent(java.lang.StringBuilder,org.apache.dubbo.common.URL,java.lang.String)>($r0, r2, "version") 

(declare-const var2467!2 var2524)
(declare-const var1084!3 String)
(declare-const var230!2 var319)
(declare-const var784 String)
(assert true)
;(assert (appendIfPresent/-1232314620 var2467!2 var1084!3 var230!2 "group")) ; Statement: specialinvoke r1.<org.apache.dubbo.registry.nacos.NacosRegistry: void appendIfPresent(java.lang.StringBuilder,org.apache.dubbo.common.URL,java.lang.String)>($r0, r2, "group") 

(declare-const var2467!3 var2524)
(declare-const var1084!4 String)
(declare-const var230!3 var319)
(declare-const var2621 String)
(assert true)
(define-const var3484 String (toString/-2075883882 var1084!4)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/-1061048412=([java.lang.StringBuilder, java.lang.String], void), appendIfPresent/-1232314620=([org.apache.dubbo.registry.nacos.NacosRegistry, java.lang.StringBuilder, org.apache.dubbo.common.URL, java.lang.String], void), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2524=org.apache.dubbo.registry.nacos.NacosRegistry, var2467=r1, var319=org.apache.dubbo.common.URL, var230=r2, var1084=$r0, var567="interface", var784="version", var2621="group", var3484=$r3}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var2524, r1=var2467, org.apache.dubbo.common.URL=var319, r2=var230, $r0=var1084, "interface"=var567, "version"=var784, "group"=var2621, $r3=var3484}
;seq <java.lang.StringBuilder: void <init>(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r2 := @parameter0: org.apache.dubbo.common.URL;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.String)>("providers");	specialinvoke r1.<org.apache.dubbo.registry.nacos.NacosRegistry: void appendIfPresent(java.lang.StringBuilder,org.apache.dubbo.common.URL,java.lang.String)>($r0, r2, "interface");	specialinvoke r1.<org.apache.dubbo.registry.nacos.NacosRegistry: void appendIfPresent(java.lang.StringBuilder,org.apache.dubbo.common.URL,java.lang.String)>($r0, r2, "version");	specialinvoke r1.<org.apache.dubbo.registry.nacos.NacosRegistry: void appendIfPresent(java.lang.StringBuilder,org.apache.dubbo.common.URL,java.lang.String)>($r0, r2, "group");	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 1