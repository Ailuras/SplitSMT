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

(declare-sort var3135 0)
(declare-sort var3842 0)
(declare-sort var1556 0)
(declare-sort var45 0)
(declare-sort var1610 0)
(declare-sort var1003 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1610_getUrl/938756954 (var1610) var45)
(declare-fun cast-from-var3842-to-var1610 (var3842) var1610)
(declare-fun getParameterAndDecoded/930711402 (var45 String String) String)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun length/-171891354 (String) Int)
(declare-fun var1003_isNotEmpty/-1251449450 (String) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3135 var3135)
(declare-const null-var3842 var3842)
(declare-const null-String String)
(declare-const var2013 var3135) ; Statement: r4 := @this: org.apache.dubbo.remoting.telnet.support.TelnetHandlerAdapter 
(assert (not (= var2013 null-var3135)))
(declare-const var2811 var3842) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2811 null-var3842)))
(declare-const var3875 String) ; Statement: r14 := @parameter1: java.lang.String 
(assert (not (= var3875 null-String)))
(define-const var1879 var45 (var1610_getUrl/938756954 (cast-from-var3842-to-var1610 var2811))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var875 String (getParameterAndDecoded/930711402 var1879 "prompt" "dubbo>")) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameterAndDecoded(java.lang.String,java.lang.String)>("prompt", "dubbo>") 
(assert true)
(define-const var1194 Bool (contains/1009244746 var3875 (cast-from-String-to-String "--no-prompt"))) ; Statement: z0 = virtualinvoke r14.<java.lang.String: boolean contains(java.lang.CharSequence)>("--no-prompt") 
(assert true)
(define-const var391 String (replace/2138489945 var3875 (cast-from-String-to-String "--no-prompt") (cast-from-String-to-String ""))) ; Statement: r15 = virtualinvoke r14.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("--no-prompt", "") 
(define-const var2847 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2847)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2847!1 String)
(assert (= var2847!1 ""))
(assert true)
(define-const var1959 String (trim/-847153721 var391)) ; Statement: r16 = virtualinvoke r15.<java.lang.String: java.lang.String trim()>() 
(assert true)
(define-const var574 Int (length/-134980193 var1959)) ; Statement: $i0 = virtualinvoke r16.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto r17 = "" 
(assert (<= var574 0)) ; Cond: $i0 <= 0 
(define-const var3995 String "") ; Statement: r17 = "" 
(assert true) ; Non Conditional
(assert true)
(define-const var2695 Int (length/-134980193 var3995)) ; Statement: $i1 = virtualinvoke r17.<java.lang.String: int length()>() 
 ; Statement: if $i1 <= 0 goto $i4 = virtualinvoke $r3.<java.lang.StringBuilder: int length()>() 
(assert (<= var2695 0)) ; Cond: $i1 <= 0 
(assert true)
(define-const var1997 Int (length/-171891354 var2847!1)) ; Statement: $i4 = virtualinvoke $r3.<java.lang.StringBuilder: int length()>() 
 ; Statement: if $i4 <= 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
(assert (<= var1997 0)) ; Cond: $i4 <= 0 
(define-const var2226 Bool (var1003_isNotEmpty/-1251449450 var875)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r19 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var2226 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var2234 String (toString/-2075883882 var2847!1)) ; Statement: $r19 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r19 
(check-sat)
; {var1610_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var3842-to-var1610=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getParameterAndDecoded/930711402=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), trim/-847153721=([java.lang.String], java.lang.String), length/-134980193=([java.lang.String], int), length/-171891354=([java.lang.StringBuilder], int), var1003_isNotEmpty/-1251449450=([java.lang.String], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3135=org.apache.dubbo.remoting.telnet.support.TelnetHandlerAdapter, var2013=r4, var3842=org.apache.dubbo.remoting.Channel, var2811=r0, var3875=r14, var1556=null_type, var45=org.apache.dubbo.common.URL, var1610=org.apache.dubbo.remoting.Endpoint, var1879=$r1, var875=r2, var1194=z0, var391=r15, var2847=$r3, var1959=r16, var574=$i0, var3995=r17, var2695=$i1, var1997=$i4, var1003=org.apache.dubbo.common.utils.StringUtils, var2226=$z1, var2234=$r19}
; {org.apache.dubbo.remoting.telnet.support.TelnetHandlerAdapter=var3135, r4=var2013, org.apache.dubbo.remoting.Channel=var3842, r0=var2811, r14=var3875, null_type=var1556, org.apache.dubbo.common.URL=var45, org.apache.dubbo.remoting.Endpoint=var1610, $r1=var1879, r2=var875, z0=var1194, r15=var391, $r3=var2847, r16=var1959, $i0=var574, r17=var3995, $i1=var2695, $i4=var1997, org.apache.dubbo.common.utils.StringUtils=var1003, $z1=var2226, $r19=var2234}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: int length()>;	<java.lang.String: int length()>;	<java.lang.StringBuilder: int length()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1,"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: int length()>": 2,"<java.lang.StringBuilder: int length()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r4 := @this: org.apache.dubbo.remoting.telnet.support.TelnetHandlerAdapter;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	r14 := @parameter1: java.lang.String;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameterAndDecoded(java.lang.String,java.lang.String)>("prompt", "dubbo>");	z0 = virtualinvoke r14.<java.lang.String: boolean contains(java.lang.CharSequence)>("--no-prompt");	r15 = virtualinvoke r14.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("--no-prompt", "");	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	r16 = virtualinvoke r15.<java.lang.String: java.lang.String trim()>();	$i0 = virtualinvoke r16.<java.lang.String: int length()>();	if $i0 <= 0 goto r17 = "";	r17 = "";	$i1 = virtualinvoke r17.<java.lang.String: int length()>();	if $i1 <= 0 goto $i4 = virtualinvoke $r3.<java.lang.StringBuilder: int length()>();	$i4 = virtualinvoke $r3.<java.lang.StringBuilder: int length()>();	if $i4 <= 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r19 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r19 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r19
;block_num 6