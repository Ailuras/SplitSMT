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

(declare-sort var2639 0)
(declare-sort var562 0)
(declare-sort var3576 0)
(declare-sort var1782 0)
(declare-sort var1116 0)
(declare-sort var946 0)
(declare-sort var643 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var562 String) String)
(declare-fun var3576_isNotBlank/-358081771 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var946) String)
(declare-fun cast-from-var562-to-var946 (var562) var946)
(declare-fun var2639_size/-959786421 (var2639) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1782_info/484404803 (var1782 String) void)
(declare-fun var2639_addAll/-525367613 (var2639 var643) Bool)
(declare-fun cast-from-var2639-to-var643 (var2639) var643)
(declare-const null-var2639 var2639)
(declare-const null-var562 var562)
(declare-const var1116-LOGGER var1782)
(declare-const var3144 var2639) ; Statement: r10 := @parameter0: java.util.List 
(assert (not (= var3144 null-var2639)))
(declare-const var2062 var2639) ; Statement: r6 := @parameter1: java.util.List 
(assert (not (= var2062 null-var2639)))
(declare-const var2932 var562) ; Statement: r0 := @parameter2: org.apache.dubbo.common.URL 
(assert (not (= var2932 null-var562)))
(assert true)
(define-const var3959 String (getParameter/-1307325648 var2932 "attachments")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("attachments") 
(define-const var3898 Bool (var3576_isNotBlank/-358081771 (cast-from-String-to-String var3959))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = <org.apache.dubbo.registry.multiple.MultipleRegistry: org.apache.dubbo.common.logger.Logger LOGGER> 
(assert (= (ite var3898 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3504 var1782 var1116-LOGGER) ; Statement: $r3 = <org.apache.dubbo.registry.multiple.MultipleRegistry: org.apache.dubbo.common.logger.Logger LOGGER> 
(define-const var1461 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1461)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1461!1 String)
(assert (= var1461!1 ""))
(assert true)
(define-const var907 String (append/672562846 var1461!1 "Single registry ")) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Single registry ") 
(declare-const var1461!2 String)
(assert (= var1461!2 (str.++ var1461!1 "Single registry ")))
(assert true)
(define-const var3523 String (append/-1031950772 var907 (cast-from-var562-to-var946 var2932))) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var907!1 String)
(assert (str.prefixof var907 var907!1))
(assert true)
(define-const var660 String (append/672562846 var3523 " has url size ")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" has url size ") 
(declare-const var3523!1 String)
(assert (= var3523!1 (str.++ var3523 " has url size ")))
(define-const var939 Int (var2639_size/-959786421 var2062)) ; Statement: $i0 = interfaceinvoke r6.<java.util.List: int size()>() 
(assert true)
(define-const var1182 String (append/-1001720160 var660 var939)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var660!1 String)
(assert (str.prefixof var660 var660!1))
(assert true)
(define-const var412 String (toString/-2075883882 var1182)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1782_info/484404803 var3504 var412)) ; Statement: interfaceinvoke $r3.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r9) 

(declare-const var3504!1 var1782)
(declare-const var412!1 String)
;(assert (var2639_addAll/-525367613 var3144 (cast-from-var2639-to-var643 var2062))) ; Statement: interfaceinvoke r10.<java.util.List: boolean addAll(java.util.Collection)>(r6) 

(declare-const var3144!1 var2639)
(declare-const var2062!1 var2639)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3576_isNotBlank/-358081771=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var562-to-var946=([org.apache.dubbo.common.URL], java.lang.Object), var2639_size/-959786421=([java.util.List], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1782_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), var2639_addAll/-525367613=([java.util.List, java.util.Collection], boolean), cast-from-var2639-to-var643=([java.util.List], java.util.Collection)}
; {var2639=java.util.List, var3144=r10, var2062=r6, var562=org.apache.dubbo.common.URL, var2932=r0, var3959=r1, var3576=org.apache.dubbo.common.utils.StringUtils, var3898=$z0, var1782=org.apache.dubbo.common.logger.Logger, var1116=org.apache.dubbo.registry.multiple.MultipleRegistry, var3504=$r3, var1461=$r2, var907=$r4, var946=java.lang.Object, var3523=$r5, var660=$r7, var939=$i0, var1182=$r8, var412=$r9, var643=java.util.Collection}
; {java.util.List=var2639, r10=var3144, r6=var2062, org.apache.dubbo.common.URL=var562, r0=var2932, r1=var3959, org.apache.dubbo.common.utils.StringUtils=var3576, $z0=var3898, org.apache.dubbo.common.logger.Logger=var1782, org.apache.dubbo.registry.multiple.MultipleRegistry=var1116, $r3=var3504, $r2=var1461, $r4=var907, java.lang.Object=var946, $r5=var3523, $r7=var660, $i0=var939, $r8=var1182, $r9=var412, java.util.Collection=var643}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r10 := @parameter0: java.util.List;	r6 := @parameter1: java.util.List;	r0 := @parameter2: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("attachments");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>(r1);	if $z0 == 0 goto $r3 = <org.apache.dubbo.registry.multiple.MultipleRegistry: org.apache.dubbo.common.logger.Logger LOGGER>;	$r3 = <org.apache.dubbo.registry.multiple.MultipleRegistry: org.apache.dubbo.common.logger.Logger LOGGER>;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Single registry ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" has url size ");	$i0 = interfaceinvoke r6.<java.util.List: int size()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r3.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r9);	interfaceinvoke r10.<java.util.List: boolean addAll(java.util.Collection)>(r6);	return
;block_num 3