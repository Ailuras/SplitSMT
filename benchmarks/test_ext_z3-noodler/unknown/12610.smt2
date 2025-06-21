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

(declare-sort var2386 0)
(declare-sort var2213 0)
(declare-sort var3357 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3357_getVersion/310196261 () String)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2386 var2386)
(declare-const null-var2213 var2213)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var2771 var2386) ; Statement: r3 := @this: org.apache.dubbo.qos.command.impl.Version 
(assert (not (= var2771 null-var2386)))
(declare-const var3907 var2213) ; Statement: r4 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var3907 null-var2213)))
(declare-const var270 (Array Int String)) ; Statement: r5 := @parameter1: java.lang.String[] 
(assert (not (= var270 null-__Array__Int__String__)))
(define-const var3070 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3070)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3070!1 String)
(assert (= var3070!1 ""))
(assert true)
;(assert (append/672562846 var3070!1 "dubbo version \u0022")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo version \"") 
(declare-const var3070!2 String)
(assert (= var3070!2 (str.++ var3070!1 "dubbo version \u0022")))
(define-const var2816 String var3357_getVersion/310196261) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>() 
(assert true)
;(assert (append/672562846 var3070!2 var2816)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r1) 
(declare-const var3070!3 String)
(assert (= var3070!3 (str.++ var3070!2 var2816)))
(assert true)
;(assert (append/-1166366385 var3070!3 34)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(34) 
(declare-const var3070!4 String)
(assert (str.prefixof var3070!3 var3070!4))
(assert true)
(define-const var2253 String (toString/-2075883882 var3070!4)) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r2 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3357_getVersion/310196261=([], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2386=org.apache.dubbo.qos.command.impl.Version, var2771=r3, var2213=org.apache.dubbo.qos.api.CommandContext, var3907=r4, var270=r5, var3070=$r0, var3357=org.apache.dubbo.common.Version, var2816=$r1, var2253=$r2}
; {org.apache.dubbo.qos.command.impl.Version=var2386, r3=var2771, org.apache.dubbo.qos.api.CommandContext=var2213, r4=var3907, r5=var270, $r0=var3070, org.apache.dubbo.common.Version=var3357, $r1=var2816, $r2=var2253}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.qos.command.impl.Version;	r4 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r5 := @parameter1: java.lang.String[];	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo version \"");	$r1 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r1);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(34);	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r2
;block_num 1