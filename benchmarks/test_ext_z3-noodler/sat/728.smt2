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

(declare-sort var334 0)
(declare-sort var21 0)
(declare-sort var3822 0)
(declare-sort var3773 0)
(declare-sort var2798 0)
(declare-sort var2526 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun <init>/2052548810 (String String) void)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3773_valueOf/-778994652 (String) var3773)
(declare-fun var2798_appendMatchCondition/94502344 (var3773 var21) var3773)
(declare-fun var334_add/328494887 (var334 var2526) Bool)
(declare-fun cast-from-var3773-to-var2526 (var3773) var2526)
(declare-const null-String String)
(declare-const null-var334 var334)
(declare-const null-var21 var21)
(declare-const var3547 String) ; Statement: r1 := @parameter0: java.lang.StringBuilder 
(assert (not (= var3547 null-String)))
(declare-const var2418 var334) ; Statement: r2 := @parameter1: java.util.List 
(assert (not (= var2418 null-var334)))
(declare-const var2199 var21) ; Statement: r7 := @parameter2: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem 
(assert (not (= var2199 null-var21)))
(declare-const var1733 String) ; Statement: r3 := @parameter3: java.lang.String 
(assert (not (= var1733 null-String)))
(define-const var172 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/2052548810 var172 (cast-from-String-to-String var3547))) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.CharSequence)>(r1) 

(declare-const var172!1 String)
(declare-const var3547!1 String)
(assert true)
(define-const var1220 String (append/672562846 var172!1 "&application=")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&application=") 
(declare-const var172!2 String)
(assert (= var172!2 (str.++ var172!1 "&application=")))
(assert true)
(define-const var2871 String (append/672562846 var1220 var1733)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var1220!1 String)
(assert (= var1220!1 (str.++ var1220 var1733)))
(assert true)
(define-const var933 String (toString/-2075883882 var2871)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var498 var3773 (var3773_valueOf/-778994652 var933)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r6) 
(define-const var2123 var3773 (var2798_appendMatchCondition/94502344 var498 var2199)) ; Statement: $r9 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: org.apache.dubbo.common.URL appendMatchCondition(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem)>($r8, r7) 
;(assert (var334_add/328494887 var2418 (cast-from-var3773-to-var2526 var2123))) ; Statement: interfaceinvoke r2.<java.util.List: boolean add(java.lang.Object)>($r9) 

(declare-const var2418!1 var334)
(declare-const var2123!1 var3773)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/2052548810=([java.lang.StringBuilder, java.lang.CharSequence], void), cast-from-String-to-String=([java.lang.StringBuilder], java.lang.CharSequence), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3773_valueOf/-778994652=([java.lang.String], org.apache.dubbo.common.URL), var2798_appendMatchCondition/94502344=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem], org.apache.dubbo.common.URL), var334_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var3773-to-var2526=([org.apache.dubbo.common.URL], java.lang.Object)}
; {var3547=r1, var334=java.util.List, var2418=r2, var21=org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem, var2199=r7, var1733=r3, var3822=null_type, var172=$r0, var1220=$r4, var2871=$r5, var933=$r6, var3773=org.apache.dubbo.common.URL, var498=$r8, var2798=org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser, var2123=$r9, var2526=java.lang.Object}
; {r1=var3547, java.util.List=var334, r2=var2418, org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem=var21, r7=var2199, r3=var1733, null_type=var3822, $r0=var172, $r4=var1220, $r5=var2871, $r6=var933, org.apache.dubbo.common.URL=var3773, $r8=var498, org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser=var2798, $r9=var2123, java.lang.Object=var2526}
;seq <java.lang.StringBuilder: void <init>(java.lang.CharSequence)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.StringBuilder;	r2 := @parameter1: java.util.List;	r7 := @parameter2: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem;	r3 := @parameter3: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>(java.lang.CharSequence)>(r1);	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&application=");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r8 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r6);	$r9 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: org.apache.dubbo.common.URL appendMatchCondition(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem)>($r8, r7);	interfaceinvoke r2.<java.util.List: boolean add(java.lang.Object)>($r9);	return
;block_num 1