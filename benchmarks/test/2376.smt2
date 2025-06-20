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

(declare-sort var3675 0)
(declare-sort var2113 0)
(declare-sort var2209 0)
(declare-sort var1048 0)
(declare-sort var274 0)
(declare-sort var2264 0)
(declare-sort var3019 0)
(declare-sort var2047 0)
(declare-sort var3251 0)
(declare-sort var980 0)
(declare-sort var1014 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2113-init () var2113)
(declare-fun <init>/-201242697 (var2113) void)
(declare-fun var2209_isEmpty/-813097145 (String) Bool)
(declare-fun var1048-init () var1048)
(declare-fun <init>/964458484 (var1048) void)
(declare-fun var274-init () var274)
(declare-fun <init>/814598262 (var274 String) void)
(declare-fun load/-763042273 (var1048 var2264) void)
(declare-fun cast-from-var274-to-var2264 (var274) var2264)
(declare-fun stringPropertyNames/841652110 (var1048) var3019)
(declare-fun var3251_bootstrap$/-290360397 (var980 var1048) var2047)
(declare-fun cast-from-var2113-to-var980 (var2113) var980)
(declare-fun var1014_forEach/-1836413473 (var1014 var2047) void)
(declare-fun cast-from-var3019-to-var1014 (var3019) var1014)
(declare-const null-String String)
(declare-const var1575 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1575 null-String)))
(define-const var2754 var2113 var2113-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2754)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>()>() 

(declare-const var2754!1 var2113)
(define-const var667 Bool (var2209_isEmpty/-813097145 var1575)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = new java.util.Properties 
(assert (= (ite var667 1 0) 0)) ; Cond: $z0 == 0 
(define-const var379 var1048 var1048-init) ; Statement: $r2 = new java.util.Properties 
(assert true)
;(assert (<init>/964458484 var379)) ; Statement: specialinvoke $r2.<java.util.Properties: void <init>()>() 

(declare-const var379!1 var1048)
(define-const var3041 var274 var274-init) ; Statement: $r3 = new java.io.StringReader 
(assert true)
;(assert (<init>/814598262 var3041 var1575)) ; Statement: specialinvoke $r3.<java.io.StringReader: void <init>(java.lang.String)>(r1) 

(declare-const var3041!1 var274)
(declare-const var1575!1 String)
(assert true)
;(assert (load/-763042273 var379!1 (cast-from-var274-to-var2264 var3041!1))) ; Statement: virtualinvoke $r2.<java.util.Properties: void load(java.io.Reader)>($r3) 

(declare-const var379!2 var1048)
(declare-const var3041!2 var274)
(assert true)
(define-const var3666 var3019 (stringPropertyNames/841652110 var379!2)) ; Statement: $r5 = virtualinvoke $r2.<java.util.Properties: java.util.Set stringPropertyNames()>() 
(define-const var3878 var2047 (var3251_bootstrap$/-290360397 (cast-from-var2113-to-var980 var2754!1) var379!2)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils$lambda_parseProperties_1__146: java.util.function.Consumer bootstrap$(java.util.Map,java.util.Properties)>($r0, $r2) 
;(assert (var1014_forEach/-1836413473 (cast-from-var3019-to-var1014 var3666) var3878)) ; Statement: interfaceinvoke $r5.<java.util.Set: void forEach(java.util.function.Consumer)>($r4) 

(declare-const var3666!1 var3019)
(declare-const var3878!1 var2047)
(assert true) ; Non Conditional
 ; Statement: return $r0 
(check-sat)
; {var2113-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), var2209_isEmpty/-813097145=([java.lang.String], boolean), var1048-init=([], java.util.Properties), <init>/964458484=([java.util.Properties], void), var274-init=([], java.io.StringReader), <init>/814598262=([java.io.StringReader, java.lang.String], void), load/-763042273=([java.util.Properties, java.io.Reader], void), cast-from-var274-to-var2264=([java.io.StringReader], java.io.Reader), stringPropertyNames/841652110=([java.util.Properties], java.util.Set), var3251_bootstrap$/-290360397=([java.util.Map, java.util.Properties], java.util.function.Consumer), cast-from-var2113-to-var980=([java.util.HashMap], java.util.Map), var1014_forEach/-1836413473=([java.lang.Iterable, java.util.function.Consumer], void), cast-from-var3019-to-var1014=([java.util.Set], java.lang.Iterable)}
; {var1575=r1, var3675=null_type, var2113=java.util.HashMap, var2754=$r0, var2209=org.apache.dubbo.common.utils.StringUtils, var667=$z0, var1048=java.util.Properties, var379=$r2, var274=java.io.StringReader, var3041=$r3, var2264=java.io.Reader, var3019=java.util.Set, var3666=$r5, var2047=java.util.function.Consumer, var3251=org.apache.dubbo.common.config.ConfigurationUtils$lambda_parseProperties_1__146, var980=java.util.Map, var3878=$r4, var1014=java.lang.Iterable}
; {r1=var1575, null_type=var3675, java.util.HashMap=var2113, $r0=var2754, org.apache.dubbo.common.utils.StringUtils=var2209, $z0=var667, java.util.Properties=var1048, $r2=var379, java.io.StringReader=var274, $r3=var3041, java.io.Reader=var2264, java.util.Set=var3019, $r5=var3666, java.util.function.Consumer=var2047, org.apache.dubbo.common.config.ConfigurationUtils$lambda_parseProperties_1__146=var3251, java.util.Map=var980, $r4=var3878, java.lang.Iterable=var1014}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = new java.util.Properties;	$r2 = new java.util.Properties;	specialinvoke $r2.<java.util.Properties: void <init>()>();	$r3 = new java.io.StringReader;	specialinvoke $r3.<java.io.StringReader: void <init>(java.lang.String)>(r1);	virtualinvoke $r2.<java.util.Properties: void load(java.io.Reader)>($r3);	$r5 = virtualinvoke $r2.<java.util.Properties: java.util.Set stringPropertyNames()>();	$r4 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils$lambda_parseProperties_1__146: java.util.function.Consumer bootstrap$(java.util.Map,java.util.Properties)>($r0, $r2);	interfaceinvoke $r5.<java.util.Set: void forEach(java.util.function.Consumer)>($r4);	return $r0
;block_num 3