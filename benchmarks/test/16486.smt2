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

(declare-sort var391 0)
(declare-sort var1337 0)
(declare-sort var2952 0)
(declare-sort var1068 0)
(declare-sort var1410 0)
(declare-sort var1074 0)
(declare-sort var1641 0)
(declare-sort var1204 0)
(declare-sort var2451 0)
(declare-sort var1815 0)
(declare-sort var1100 0)
(declare-sort var3763 0)
(declare-sort var3390 0)
(declare-sort var1244 0)
(declare-sort var3981 0)
(declare-sort var3607 0)
(declare-sort var1221 0)
(declare-sort var1766 0)
(declare-sort var1818 0)
(declare-sort var986 0)
(declare-sort var2137 0)
(declare-sort var426 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1815!class ClassObject)
(declare-fun var1410_getUrl/938756954 (var1410) var1068)
(declare-fun cast-from-var1337-to-var1410 (var1337) var1410)
(declare-fun getScopeModel/-1957927771 (var1068) var1074)
(declare-fun var1204_getApplicationModel/75536413 (var1074) var1641)
(declare-fun getExtensionLoader/-514331157 (var1100 ClassObject) var2451)
(declare-fun cast-from-var1641-to-var1100 (var1641) var1100)
(declare-fun getActivateExtension/-62970668 (var2451 var1068 String) var3763)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var3390-init () var3390)
(declare-fun <init>/-325640736 (var3390) void)
(declare-fun var1244-init () var1244)
(declare-fun <init>/-201242697 (var1244) void)
(declare-fun var3981_isNotEmpty/-572947236 (var3607) Bool)
(declare-fun cast-from-var3763-to-var3607 (var3763) var3607)
(declare-fun var1766_getSummaryStatus/-2029479363 (var1818) var1221)
(declare-fun cast-from-var1244-to-var1818 (var1244) var1818)
(declare-fun var3763_add/328494887 (var3763 var986) Bool)
(declare-fun cast-from-var3390-to-var3763 (var3390) var3763)
(declare-fun cast-from-String-to-var986 (String) var986)
(declare-fun getLevel/-1795247963 (var1221) var2137)
(declare-fun String_valueOf/-333372740 (var986) String)
(declare-fun cast-from-var2137-to-var986 (var2137) var986)
(declare-fun getMessage/998814252 (var1221) String)
(declare-fun cast-from-var3390-to-var986 (var3390) var986)
(declare-fun var426_toTable/-764623085 ((Array Int String) var3763) String)
(declare-const null-var391 var391)
(declare-const null-var1337 var1337)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var2076 var391) ; Statement: r45 := @this: org.apache.dubbo.remoting.telnet.support.command.StatusTelnetHandler 
(assert (not (= var2076 null-var391)))
(declare-const var958 var1337) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var958 null-var1337)))
(declare-const var1168 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var1168 null-String)))
(define-const var737 var1068 (var1410_getUrl/938756954 (cast-from-var1337-to-var1410 var958))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1632 var1074 (getScopeModel/-1957927771 var737)) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(define-const var540 var1641 (var1204_getApplicationModel/75536413 var1632)) ; Statement: r3 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>($r2) 
(assert true)
(define-const var1828 var2451 (getExtensionLoader/-514331157 (cast-from-var1641-to-var1100 var540) var1815!class)) ; Statement: r4 = virtualinvoke r3.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/status/StatusChecker;") 
(define-const var3003 String "-l") ; Statement: $r6 = "-l" 
(assert true)
(define-const var2800 Bool (= var3003 var1168)) ; Statement: $z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>(r5) 
 ; Statement: if $z0 == 0 goto $i0 = virtualinvoke r5.<java.lang.String: int length()>() 
(assert (not (= (ite var2800 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3745 var1068 (var1410_getUrl/938756954 (cast-from-var1337-to-var1410 var958))) ; Statement: $r19 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1087 var3763 (getActivateExtension/-62970668 var1828 var3745 "status")) ; Statement: r46 = virtualinvoke r4.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String)>($r19, "status") 
(define-const var370 (Array Int String) arr-String-init) ; Statement: $r20 = newarray (java.lang.String)[3] 
(declare-const var370!1 (Array Int String))
(assert (not (= var370!1 null-__Array__Int__String__)))
(assert (= (select var370!1 0) "resource")) ; Statement: $r20[0] = "resource" 
(declare-const var370!2 (Array Int String))
(assert (not (= var370!2 null-__Array__Int__String__)))
(assert (= (select var370!2 1) "status")) ; Statement: $r20[1] = "status" 
(declare-const var370!3 (Array Int String))
(assert (not (= var370!3 null-__Array__Int__String__)))
(assert (= (select var370!3 2) "message")) ; Statement: $r20[2] = "message" 
(define-const var2615 var3390 var3390-init) ; Statement: $r21 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2615)) ; Statement: specialinvoke $r21.<java.util.ArrayList: void <init>()>() 

(declare-const var2615!1 var3390)
(define-const var3944 var1244 var1244-init) ; Statement: $r22 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var3944)) ; Statement: specialinvoke $r22.<java.util.HashMap: void <init>()>() 

(declare-const var3944!1 var1244)
(define-const var629 Bool (var3981_isNotEmpty/-572947236 (cast-from-var3763-to-var3607 var1087))) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r46) 
 ; Statement: if $z2 == 0 goto $r28 = staticinvoke <org.apache.dubbo.common.status.support.StatusUtils: org.apache.dubbo.common.status.Status getSummaryStatus(java.util.Map)>($r22) 
(assert (= (ite var629 1 0) 0)) ; Cond: $z2 == 0 
(define-const var944 var1221 (var1766_getSummaryStatus/-2029479363 (cast-from-var1244-to-var1818 var3944!1))) ; Statement: $r28 = staticinvoke <org.apache.dubbo.common.status.support.StatusUtils: org.apache.dubbo.common.status.Status getSummaryStatus(java.util.Map)>($r22) 
(define-const var1363 var3390 var3390-init) ; Statement: $r23 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1363)) ; Statement: specialinvoke $r23.<java.util.ArrayList: void <init>()>() 

(declare-const var1363!1 var3390)
;(assert (var3763_add/328494887 (cast-from-var3390-to-var3763 var1363!1) (cast-from-String-to-var986 "summary"))) ; Statement: interfaceinvoke $r23.<java.util.List: boolean add(java.lang.Object)>("summary") 

(declare-const var1363!2 var3390)
(declare-const var1210 String)
(assert true)
(define-const var276 var2137 (getLevel/-1795247963 var944)) ; Statement: $r24 = virtualinvoke $r28.<org.apache.dubbo.common.status.Status: org.apache.dubbo.common.status.Status$Level getLevel()>() 
(define-const var953 String (String_valueOf/-333372740 (cast-from-var2137-to-var986 var276))) ; Statement: $r25 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r24) 
;(assert (var3763_add/328494887 (cast-from-var3390-to-var3763 var1363!2) (cast-from-String-to-var986 var953))) ; Statement: interfaceinvoke $r23.<java.util.List: boolean add(java.lang.Object)>($r25) 

(declare-const var1363!3 var3390)
(declare-const var953!1 String)
(assert true)
(define-const var1792 String (getMessage/998814252 var944)) ; Statement: $r26 = virtualinvoke $r28.<org.apache.dubbo.common.status.Status: java.lang.String getMessage()>() 
;(assert (var3763_add/328494887 (cast-from-var3390-to-var3763 var1363!3) (cast-from-String-to-var986 var1792))) ; Statement: interfaceinvoke $r23.<java.util.List: boolean add(java.lang.Object)>($r26) 

(declare-const var1363!4 var3390)
(declare-const var1792!1 String)
;(assert (var3763_add/328494887 (cast-from-var3390-to-var3763 var2615!1) (cast-from-var3390-to-var986 var1363!4))) ; Statement: interfaceinvoke $r21.<java.util.List: boolean add(java.lang.Object)>($r23) 

(declare-const var2615!2 var3390)
(declare-const var1363!5 var3390)
(define-const var206 String (var426_toTable/-764623085 var370!3 (cast-from-var3390-to-var3763 var2615!2))) ; Statement: $r27 = staticinvoke <org.apache.dubbo.remoting.telnet.support.TelnetUtils: java.lang.String toTable(java.lang.String[],java.util.List)>($r20, $r21) 
 ; Statement: return $r27 
(check-sat)
; {var1410_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var1337-to-var1410=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getScopeModel/-1957927771=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ScopeModel), var1204_getApplicationModel/75536413=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.rpc.model.ApplicationModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var1641-to-var1100=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.extension.ExtensionAccessor), getActivateExtension/-62970668=([org.apache.dubbo.common.extension.ExtensionLoader, org.apache.dubbo.common.URL, java.lang.String], java.util.List), arr-String-init=([], java.lang.String[]), var3390-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var1244-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), var3981_isNotEmpty/-572947236=([java.util.Collection], boolean), cast-from-var3763-to-var3607=([java.util.List], java.util.Collection), var1766_getSummaryStatus/-2029479363=([java.util.Map], org.apache.dubbo.common.status.Status), cast-from-var1244-to-var1818=([java.util.HashMap], java.util.Map), var3763_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var3390-to-var3763=([java.util.ArrayList], java.util.List), cast-from-String-to-var986=([java.lang.String], java.lang.Object), getLevel/-1795247963=([org.apache.dubbo.common.status.Status], org.apache.dubbo.common.status.Status$Level), String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var2137-to-var986=([org.apache.dubbo.common.status.Status$Level], java.lang.Object), getMessage/998814252=([org.apache.dubbo.common.status.Status], java.lang.String), cast-from-var3390-to-var986=([java.util.ArrayList], java.lang.Object), var426_toTable/-764623085=([java.lang.String[], java.util.List], java.lang.String)}
; {var391=org.apache.dubbo.remoting.telnet.support.command.StatusTelnetHandler, var2076=r45, var1337=org.apache.dubbo.remoting.Channel, var958=r0, var1168=r5, var2952=null_type, var1068=org.apache.dubbo.common.URL, var1410=org.apache.dubbo.remoting.Endpoint, var737=$r1, var1074=org.apache.dubbo.rpc.model.ScopeModel, var1632=$r2, var1641=org.apache.dubbo.rpc.model.ApplicationModel, var1204=org.apache.dubbo.rpc.model.ScopeModelUtil, var540=r3, var2451=org.apache.dubbo.common.extension.ExtensionLoader, var1815=org.apache.dubbo.common.status.StatusChecker, var1100=org.apache.dubbo.common.extension.ExtensionAccessor, var1828=r4, var3003=$r6, var2800=$z0, var3745=$r19, var3763=java.util.List, var1087=r46, var370=$r20, var3390=java.util.ArrayList, var2615=$r21, var1244=java.util.HashMap, var3944=$r22, var3981=org.apache.dubbo.common.utils.CollectionUtils, var3607=java.util.Collection, var629=$z2, var1221=org.apache.dubbo.common.status.Status, var1766=org.apache.dubbo.common.status.support.StatusUtils, var1818=java.util.Map, var944=$r28, var1363=$r23, var986=java.lang.Object, var1210="summary", var2137=org.apache.dubbo.common.status.Status$Level, var276=$r24, var953=$r25, var1792=$r26, var426=org.apache.dubbo.remoting.telnet.support.TelnetUtils, var206=$r27}
; {org.apache.dubbo.remoting.telnet.support.command.StatusTelnetHandler=var391, r45=var2076, org.apache.dubbo.remoting.Channel=var1337, r0=var958, r5=var1168, null_type=var2952, org.apache.dubbo.common.URL=var1068, org.apache.dubbo.remoting.Endpoint=var1410, $r1=var737, org.apache.dubbo.rpc.model.ScopeModel=var1074, $r2=var1632, org.apache.dubbo.rpc.model.ApplicationModel=var1641, org.apache.dubbo.rpc.model.ScopeModelUtil=var1204, r3=var540, org.apache.dubbo.common.extension.ExtensionLoader=var2451, org.apache.dubbo.common.status.StatusChecker=var1815, org.apache.dubbo.common.extension.ExtensionAccessor=var1100, r4=var1828, $r6=var3003, $z0=var2800, $r19=var3745, java.util.List=var3763, r46=var1087, $r20=var370, java.util.ArrayList=var3390, $r21=var2615, java.util.HashMap=var1244, $r22=var3944, org.apache.dubbo.common.utils.CollectionUtils=var3981, java.util.Collection=var3607, $z2=var629, org.apache.dubbo.common.status.Status=var1221, org.apache.dubbo.common.status.support.StatusUtils=var1766, java.util.Map=var1818, $r28=var944, $r23=var1363, java.lang.Object=var986, "summary"=var1210, org.apache.dubbo.common.status.Status$Level=var2137, $r24=var276, $r25=var953, $r26=var1792, org.apache.dubbo.remoting.telnet.support.TelnetUtils=var426, $r27=var206}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r45 := @this: org.apache.dubbo.remoting.telnet.support.command.StatusTelnetHandler;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	r5 := @parameter1: java.lang.String;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	r3 = staticinvoke <org.apache.dubbo.rpc.model.ScopeModelUtil: org.apache.dubbo.rpc.model.ApplicationModel getApplicationModel(org.apache.dubbo.rpc.model.ScopeModel)>($r2);	r4 = virtualinvoke r3.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/status/StatusChecker;");	$r6 = "-l";	$z0 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>(r5);	if $z0 == 0 goto $i0 = virtualinvoke r5.<java.lang.String: int length()>();	$r19 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	r46 = virtualinvoke r4.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.List getActivateExtension(org.apache.dubbo.common.URL,java.lang.String)>($r19, "status");	$r20 = newarray (java.lang.String)[3];	$r20[0] = "resource";	$r20[1] = "status";	$r20[2] = "message";	$r21 = new java.util.ArrayList;	specialinvoke $r21.<java.util.ArrayList: void <init>()>();	$r22 = new java.util.HashMap;	specialinvoke $r22.<java.util.HashMap: void <init>()>();	$z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r46);	if $z2 == 0 goto $r28 = staticinvoke <org.apache.dubbo.common.status.support.StatusUtils: org.apache.dubbo.common.status.Status getSummaryStatus(java.util.Map)>($r22);	$r28 = staticinvoke <org.apache.dubbo.common.status.support.StatusUtils: org.apache.dubbo.common.status.Status getSummaryStatus(java.util.Map)>($r22);	$r23 = new java.util.ArrayList;	specialinvoke $r23.<java.util.ArrayList: void <init>()>();	interfaceinvoke $r23.<java.util.List: boolean add(java.lang.Object)>("summary");	$r24 = virtualinvoke $r28.<org.apache.dubbo.common.status.Status: org.apache.dubbo.common.status.Status$Level getLevel()>();	$r25 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r24);	interfaceinvoke $r23.<java.util.List: boolean add(java.lang.Object)>($r25);	$r26 = virtualinvoke $r28.<org.apache.dubbo.common.status.Status: java.lang.String getMessage()>();	interfaceinvoke $r23.<java.util.List: boolean add(java.lang.Object)>($r26);	interfaceinvoke $r21.<java.util.List: boolean add(java.lang.Object)>($r23);	$r27 = staticinvoke <org.apache.dubbo.remoting.telnet.support.TelnetUtils: java.lang.String toTable(java.lang.String[],java.util.List)>($r20, $r21);	return $r27
;block_num 3