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

(declare-sort var791 0)
(declare-sort var2414 0)
(declare-sort var1804 0)
(declare-sort var3642 0)
(declare-sort var399 0)
(declare-sort var65 0)
(declare-sort var2259 0)
(declare-sort var463 0)
(declare-sort var1782 0)
(declare-sort var987 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun getKey/-167330824 (var791) String)
(declare-fun var399_appendService/518136222 (String) String)
(declare-fun var399_toParameterString/-1610486872 (var2414) String)
(declare-fun var399_parseEnabled/-164526871 (var2414 var791 String) void)
(declare-fun getConfigVersion/-1950266559 (var791) String)
(declare-fun getApplications/1922586505 (var2414) var1804)
(declare-fun var65_isNotEmpty/-572947236 (var2259) Bool)
(declare-fun cast-from-var1804-to-var2259 (var1804) var2259)
(declare-fun var1782_bootstrap$/2090864384 (String var1804 var2414) var463)
(declare-fun var987_forEach/-1836413473 (var987 var463) void)
(declare-fun cast-from-var1804-to-var987 (var1804) var987)
(declare-const null-var791 var791)
(declare-const null-var2414 var2414)
(declare-const null-var1804 var1804)
(declare-const null-String String)
(declare-const var648 var791) ; Statement: r4 := @parameter0: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig 
(assert (not (= var648 null-var791)))
(declare-const var2714 var2414) ; Statement: r7 := @parameter1: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem 
(assert (not (= var2714 null-var2414)))
(declare-const var3622 var1804) ; Statement: r12 := @parameter2: java.util.List 
(assert (not (= var3622 null-var1804)))
(declare-const var3108 String) ; Statement: r1 := @parameter3: java.lang.String 
(assert (not (= var3108 null-String)))
(define-const var1094 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1094)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1094!1 String)
(assert (= var1094!1 ""))
(assert true)
(define-const var432 String (append/672562846 var1094!1 "override://")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("override://") 
(declare-const var1094!2 String)
(assert (= var1094!2 (str.++ var1094!1 "override://")))
(assert true)
(define-const var387 String (append/672562846 var432 var3108)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var432!1 String)
(assert (= var432!1 (str.++ var432 var3108)))
(assert true)
;(assert (append/-1166366385 var387 47)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47) 
(declare-const var387!1 String)
(assert (str.prefixof var387 var387!1))
(assert true)
(define-const var342 String (getKey/-167330824 var648)) ; Statement: $r5 = virtualinvoke r4.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig: java.lang.String getKey()>() 
(define-const var52 String (var399_appendService/518136222 var342)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: java.lang.String appendService(java.lang.String)>($r5) 
(assert true)
;(assert (append/672562846 var1094!2 var52)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1094!3 String)
(assert (= var1094!3 (str.++ var1094!2 var52)))
(define-const var1387 String (var399_toParameterString/-1610486872 var2714)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: java.lang.String toParameterString(org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem)>(r7) 
(assert true)
;(assert (append/672562846 var1094!3 var1387)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var1094!4 String)
(assert (= var1094!4 (str.++ var1094!3 var1387)))
;(assert (var399_parseEnabled/-164526871 var2714 var648 var1094!4)) ; Statement: staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: void parseEnabled(org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem,org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig,java.lang.StringBuilder)>(r7, r4, $r0) 

(declare-const var2714!1 var2414)
(declare-const var648!1 var791)
(declare-const var1094!5 String)
(assert true)
(define-const var1003 String (append/672562846 var1094!5 "&configVersion=")) ; Statement: $r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&configVersion=") 
(declare-const var1094!6 String)
(assert (= var1094!6 (str.++ var1094!5 "&configVersion=")))
(assert true)
(define-const var1371 String (getConfigVersion/-1950266559 var648!1)) ; Statement: $r9 = virtualinvoke r4.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig: java.lang.String getConfigVersion()>() 
(assert true)
;(assert (append/672562846 var1003 var1371)) ; Statement: virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var1003!1 String)
(assert (= var1003!1 (str.++ var1003 var1371)))
(assert true)
(define-const var1683 var1804 (getApplications/1922586505 var2714!1)) ; Statement: r11 = virtualinvoke r7.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: java.util.List getApplications()>() 
(define-const var2335 Bool (var65_isNotEmpty/-572947236 (cast-from-var1804-to-var2259 var1683))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r11) 
 ; Statement: if $z0 == 0 goto $r13 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (not (= (ite var2335 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3194 var463 (var1782_bootstrap$/2090864384 var1094!6 var3622 var2714!1)) ; Statement: $r16 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser$lambda_serviceItemToUrls_3__10: java.util.function.Consumer bootstrap$(java.lang.StringBuilder,java.util.List,org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem)>($r0, r12, r7) 
;(assert (var987_forEach/-1836413473 (cast-from-var1804-to-var987 var1683) var3194)) ; Statement: interfaceinvoke r11.<java.util.List: void forEach(java.util.function.Consumer)>($r16) 

(declare-const var1683!1 var1804)
(declare-const var3194!1 var463)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), getKey/-167330824=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig], java.lang.String), var399_appendService/518136222=([java.lang.String], java.lang.String), var399_toParameterString/-1610486872=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem], java.lang.String), var399_parseEnabled/-164526871=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem, org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig, java.lang.StringBuilder], void), getConfigVersion/-1950266559=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig], java.lang.String), getApplications/1922586505=([org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem], java.util.List), var65_isNotEmpty/-572947236=([java.util.Collection], boolean), cast-from-var1804-to-var2259=([java.util.List], java.util.Collection), var1782_bootstrap$/2090864384=([java.lang.StringBuilder, java.util.List, org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem], java.util.function.Consumer), var987_forEach/-1836413473=([java.lang.Iterable, java.util.function.Consumer], void), cast-from-var1804-to-var987=([java.util.List], java.lang.Iterable)}
; {var791=org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig, var648=r4, var2414=org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem, var2714=r7, var1804=java.util.List, var3622=r12, var3108=r1, var3642=null_type, var1094=$r0, var432=$r2, var387=$r3, var342=$r5, var399=org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser, var52=$r6, var1387=$r8, var1003=$r10, var1371=$r9, var1683=r11, var65=org.apache.dubbo.common.utils.CollectionUtils, var2259=java.util.Collection, var2335=$z0, var463=java.util.function.Consumer, var1782=org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser$lambda_serviceItemToUrls_3__10, var3194=$r16, var987=java.lang.Iterable}
; {org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig=var791, r4=var648, org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem=var2414, r7=var2714, java.util.List=var1804, r12=var3622, r1=var3108, null_type=var3642, $r0=var1094, $r2=var432, $r3=var387, $r5=var342, org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser=var399, $r6=var52, $r8=var1387, $r10=var1003, $r9=var1371, r11=var1683, org.apache.dubbo.common.utils.CollectionUtils=var65, java.util.Collection=var2259, $z0=var2335, java.util.function.Consumer=var463, org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser$lambda_serviceItemToUrls_3__10=var1782, $r16=var3194, java.lang.Iterable=var987}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1}
;stmts r4 := @parameter0: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig;	r7 := @parameter1: org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem;	r12 := @parameter2: java.util.List;	r1 := @parameter3: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("override://");	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47);	$r5 = virtualinvoke r4.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig: java.lang.String getKey()>();	$r6 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: java.lang.String appendService(java.lang.String)>($r5);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r8 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: java.lang.String toParameterString(org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem)>(r7);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser: void parseEnabled(org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem,org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig,java.lang.StringBuilder)>(r7, r4, $r0);	$r10 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&configVersion=");	$r9 = virtualinvoke r4.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfiguratorConfig: java.lang.String getConfigVersion()>();	virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	r11 = virtualinvoke r7.<org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem: java.util.List getApplications()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r11);	if $z0 == 0 goto $r13 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r16 = staticinvoke <org.apache.dubbo.rpc.cluster.configurator.parser.ConfigParser$lambda_serviceItemToUrls_3__10: java.util.function.Consumer bootstrap$(java.lang.StringBuilder,java.util.List,org.apache.dubbo.rpc.cluster.configurator.parser.model.ConfigItem)>($r0, r12, r7);	interfaceinvoke r11.<java.util.List: void forEach(java.util.function.Consumer)>($r16);	goto [?= return];	return
;block_num 3