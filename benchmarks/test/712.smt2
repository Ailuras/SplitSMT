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

(declare-sort var1277 0)
(declare-sort var3882 0)
(declare-sort var2711 0)
(declare-sort var319 0)
(declare-sort var806 0)
(declare-sort var402 0)
(declare-sort var3313 0)
(declare-sort var2822 0)
(declare-sort var672 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getKey/-167330824 (var1277) String)
(declare-fun var806_appendService/518136222 (String) String)
(declare-fun var806_toParameterString/-1610486872 (var3882) String)
(declare-fun var806_parseEnabled/-164526871 (var3882 var1277 String) void)
(declare-fun getConfigVersion/-1950266559 (var1277) String)
(declare-fun getApplications/1922586505 (var3882) var2711)
(declare-fun var402_isNotEmpty/-572947236 (var3313) Bool)
(declare-fun cast-from-var2711-to-var3313 (var2711) var3313)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2822_valueOf/-778994652 (String) var2822)
(declare-fun var806_appendMatchCondition/94502344 (var2822 var3882) var2822)
(declare-fun var2711_add/328494887 (var2711 var672) Bool)
(declare-fun cast-from-var2822-to-var672 (var2822) var672)
(declare-const null-var1277 var1277)
(declare-const null-var3882 var3882)
(declare-const null-var2711 var2711)
(declare-const null-String String)
(declare-const var3459 var1277) ; Statement: r4 := @parameter0: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig 
(assert (not (= var3459 null-var1277)))
(declare-const var2027 var3882) ; Statement: r7 := @parameter1: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem 
(assert (not (= var2027 null-var3882)))
(declare-const var613 var2711) ; Statement: r12 := @parameter2: java.util.List 
(assert (not (= var613 null-var2711)))
(declare-const var3315 String) ; Statement: r1 := @parameter3: java.lang.String 
(assert (not (= var3315 null-String)))
(define-const var2920 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2920)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2920!1 String)
(assert (= var2920!1 ""))
(assert true)
(define-const var312 String (append/672562846 var2920!1 "override://")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("override://") 
(declare-const var2920!2 String)
(assert (= var2920!2 (str.++ var2920!1 "override://")))
(assert true)
(define-const var2370 String (append/672562846 var312 var3315)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var312!1 String)
(assert (= var312!1 (str.++ var312 var3315)))
(assert true)
;(assert (append/-1166366385 var2370 47)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47) 
(declare-const var2370!1 String)
(assert (str.prefixof var2370 var2370!1))
(assert true)
(define-const var3910 String (getKey/-167330824 var3459)) ; Statement: $r5 = virtualinvoke r4.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig: java.lang.String getKey()>() 
(define-const var2195 String (var806_appendService/518136222 var3910)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: java.lang.String appendService(java.lang.String)>($r5) 
(assert true)
;(assert (append/672562846 var2920!2 var2195)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2920!3 String)
(assert (= var2920!3 (str.++ var2920!2 var2195)))
(define-const var2111 String (var806_toParameterString/-1610486872 var2027)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: java.lang.String toParameterString(org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem)>(r7) 
(assert true)
;(assert (append/672562846 var2920!3 var2111)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var2920!4 String)
(assert (= var2920!4 (str.++ var2920!3 var2111)))
;(assert (var806_parseEnabled/-164526871 var2027 var3459 var2920!4)) ; Statement: staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: void parseEnabled(org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem,org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig,java.lang.StringBuilder)>(r7, r4, $r0) 

(declare-const var2027!1 var3882)
(declare-const var3459!1 var1277)
(declare-const var2920!5 String)
(assert true)
(define-const var3258 String (append/672562846 var2920!5 "&configVersion=")) ; Statement: $r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&configVersion=") 
(declare-const var2920!6 String)
(assert (= var2920!6 (str.++ var2920!5 "&configVersion=")))
(assert true)
(define-const var1953 String (getConfigVersion/-1950266559 var3459!1)) ; Statement: $r9 = virtualinvoke r4.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig: java.lang.String getConfigVersion()>() 
(assert true)
;(assert (append/672562846 var3258 var1953)) ; Statement: virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var3258!1 String)
(assert (= var3258!1 (str.++ var3258 var1953)))
(assert true)
(define-const var2420 var2711 (getApplications/1922586505 var2027!1)) ; Statement: r11 = virtualinvoke r7.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: java.util.List getApplications()>() 
(define-const var217 Bool (var402_isNotEmpty/-572947236 (cast-from-var2711-to-var3313 var2420))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r11) 
 ; Statement: if $z0 == 0 goto $r13 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var217 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2543 String (toString/-2075883882 var2920!6)) ; Statement: $r13 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var932 var2822 (var2822_valueOf/-778994652 var2543)) ; Statement: $r14 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r13) 
(define-const var1397 var2822 (var806_appendMatchCondition/94502344 var932 var2027!1)) ; Statement: $r15 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: org.apache.dubbo.common.URL appendMatchCondition(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem)>($r14, r7) 
;(assert (var2711_add/328494887 var613 (cast-from-var2822-to-var672 var1397))) ; Statement: interfaceinvoke r12.<java.util.List: boolean add(java.lang.Object)>($r15) 

(declare-const var613!1 var2711)
(declare-const var1397!1 var2822)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getKey/-167330824=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig], java.lang.String), var806_appendService/518136222=([java.lang.String], java.lang.String), var806_toParameterString/-1610486872=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem], java.lang.String), var806_parseEnabled/-164526871=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem, org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig, java.lang.StringBuilder], void), getConfigVersion/-1950266559=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig], java.lang.String), getApplications/1922586505=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem], java.util.List), var402_isNotEmpty/-572947236=([java.util.Collection], boolean), cast-from-var2711-to-var3313=([java.util.List], java.util.Collection), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2822_valueOf/-778994652=([java.lang.String], org.apache.dubbo.common.URL), var806_appendMatchCondition/94502344=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem], org.apache.dubbo.common.URL), var2711_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var2822-to-var672=([org.apache.dubbo.common.URL], java.lang.Object)}
; {var1277=org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig, var3459=r4, var3882=org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem, var2027=r7, var2711=java.util.List, var613=r12, var3315=r1, var319=null_type, var2920=$r0, var312=$r2, var2370=$r3, var3910=$r5, var806=org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser, var2195=$r6, var2111=$r8, var3258=$r10, var1953=$r9, var2420=r11, var402=org.apache.dubbo.common.utils.CollectionUtils, var3313=java.util.Collection, var217=$z0, var2543=$r13, var2822=org.apache.dubbo.common.URL, var932=$r14, var1397=$r15, var672=java.lang.Object}
; {org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig=var1277, r4=var3459, org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem=var3882, r7=var2027, java.util.List=var2711, r12=var613, r1=var3315, null_type=var319, $r0=var2920, $r2=var312, $r3=var2370, $r5=var3910, org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser=var806, $r6=var2195, $r8=var2111, $r10=var3258, $r9=var1953, r11=var2420, org.apache.dubbo.common.utils.CollectionUtils=var402, java.util.Collection=var3313, $z0=var217, $r13=var2543, org.apache.dubbo.common.URL=var2822, $r14=var932, $r15=var1397, java.lang.Object=var672}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r4 := @parameter0: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig;	r7 := @parameter1: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem;	r12 := @parameter2: java.util.List;	r1 := @parameter3: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("override://");	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47);	$r5 = virtualinvoke r4.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig: java.lang.String getKey()>();	$r6 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: java.lang.String appendService(java.lang.String)>($r5);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r8 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: java.lang.String toParameterString(org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem)>(r7);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: void parseEnabled(org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem,org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig,java.lang.StringBuilder)>(r7, r4, $r0);	$r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&configVersion=");	$r9 = virtualinvoke r4.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig: java.lang.String getConfigVersion()>();	virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	r11 = virtualinvoke r7.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: java.util.List getApplications()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r11);	if $z0 == 0 goto $r13 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r13 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r14 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r13);	$r15 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: org.apache.dubbo.common.URL appendMatchCondition(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem)>($r14, r7);	interfaceinvoke r12.<java.util.List: boolean add(java.lang.Object)>($r15);	return
;block_num 3