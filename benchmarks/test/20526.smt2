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

(declare-sort var2065 0)
(declare-sort var3096 0)
(declare-sort var138 0)
(declare-sort var2873 0)
(declare-sort var3057 0)
(declare-sort var3074 0)
(declare-sort var1088 0)
(declare-sort var2755 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getInvocationTime/675231966 (var2065) var3096)
(declare-fun toInstant/-822818885 (var3096) var138)
(declare-fun var2873_systemDefault/1019915793 () var2873)
(declare-fun var3057_ofInstant/129408697 (var138 var2873) var3057)
(declare-fun format/372879155 (var3057 var3074) String)
(declare-fun getOutTime/324948452 (var2065) var3096)
(declare-fun get/-1007821573 (var2065 String) var1088)
(declare-fun append/-1031950772 (String var1088) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var2755_isNotEmpty/-1251449450 (String) Bool)
(declare-fun cast-from-var1088-to-__Array__Int__ClassObject__ (var1088) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun cast-from-var1088-to-__Array__Int__var1088__ (var1088) (Array Int var1088))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2065 var2065)
(declare-const var2065-MESSAGE_DATE_FORMATTER var3074)
(declare-const null-var1088 var1088)
(declare-const null-__Array__Int__var1088__ (Array Int var1088))
(declare-const var3482 var2065) ; Statement: r1 := @this: org.apache.dubbo.rpc.support.AccessLogData 
(assert (not (= var3482 null-var2065)))
(define-const var428 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var428)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var428!1 String)
(assert (= var428!1 ""))
(assert true)
(define-const var852 String (append/672562846 var428!1 "[")) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var428!2 String)
(assert (= var428!2 (str.++ var428!1 "[")))
(assert true)
(define-const var3998 var3096 (getInvocationTime/675231966 var3482)) ; Statement: $r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>() 
(assert true)
(define-const var3786 var138 (toInstant/-822818885 var3998)) ; Statement: $r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var1330 var2873 var2873_systemDefault/1019915793) ; Statement: $r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var491 var3057 (var3057_ofInstant/129408697 var3786 var1330)) ; Statement: $r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3) 
(define-const var1097 var3074 var2065-MESSAGE_DATE_FORMATTER) ; Statement: $r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var1777 String (format/372879155 var491 var1097)) ; Statement: $r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5) 
(assert true)
(define-const var2245 String (append/672562846 var852 var1777)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var852!1 String)
(assert (= var852!1 (str.++ var852 var1777)))
(assert true)
(define-const var2008 String (append/672562846 var2245 "] ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var2245!1 String)
(assert (= var2245!1 (str.++ var2245 "] ")))
(assert true)
(define-const var802 String (append/672562846 var2008 "-> ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ") 
(declare-const var2008!1 String)
(assert (= var2008!1 (str.++ var2008 "-> ")))
(assert true)
(define-const var3589 String (append/672562846 var802 "[")) ; Statement: $r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var802!1 String)
(assert (= var802!1 (str.++ var802 "[")))
(assert true)
(define-const var3791 var3096 (getOutTime/324948452 var3482)) ; Statement: $r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>() 
(assert true)
(define-const var2675 var138 (toInstant/-822818885 var3791)) ; Statement: $r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var2321 var2873 var2873_systemDefault/1019915793) ; Statement: $r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var1508 var3057 (var3057_ofInstant/129408697 var2675 var2321)) ; Statement: $r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13) 
(define-const var3567 var3074 var2065-MESSAGE_DATE_FORMATTER) ; Statement: $r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var1857 String (format/372879155 var1508 var3567)) ; Statement: $r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15) 
(assert true)
(define-const var1692 String (append/672562846 var3589 var1857)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var3589!1 String)
(assert (= var3589!1 (str.++ var3589 var1857)))
(assert true)
(define-const var750 String (append/672562846 var1692 "] ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var1692!1 String)
(assert (= var1692!1 (str.++ var1692 "] ")))
(assert true)
(define-const var1558 var1088 (get/-1007821573 var3482 "remote-host")) ; Statement: $r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host") 
(assert true)
(define-const var3743 String (append/-1031950772 var750 var1558)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20) 
(declare-const var750!1 String)
(assert (str.prefixof var750 var750!1))
(assert true)
(define-const var2180 String (append/-1166366385 var3743 58)) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var3743!1 String)
(assert (str.prefixof var3743 var3743!1))
(assert true)
(define-const var1574 var1088 (get/-1007821573 var3482 "remote-port")) ; Statement: $r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port") 
(assert true)
(define-const var3300 String (append/-1031950772 var2180 var1574)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23) 
(declare-const var2180!1 String)
(assert (str.prefixof var2180 var2180!1))
(assert true)
(define-const var2195 String (append/672562846 var3300 " -> ")) ; Statement: $r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var3300!1 String)
(assert (= var3300!1 (str.++ var3300 " -> ")))
(assert true)
(define-const var1513 var1088 (get/-1007821573 var3482 "localhost")) ; Statement: $r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost") 
(assert true)
(define-const var3520 String (append/-1031950772 var2195 var1513)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26) 
(declare-const var2195!1 String)
(assert (str.prefixof var2195 var2195!1))
(assert true)
(define-const var2087 String (append/-1166366385 var3520 58)) ; Statement: $r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var3520!1 String)
(assert (str.prefixof var3520 var3520!1))
(assert true)
(define-const var1090 var1088 (get/-1007821573 var3482 "local-port")) ; Statement: $r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port") 
(assert true)
(define-const var3399 String (append/-1031950772 var2087 var1090)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var2087!1 String)
(assert (str.prefixof var2087 var2087!1))
(assert true)
;(assert (append/672562846 var3399 " - ")) ; Statement: virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ") 
(declare-const var3399!1 String)
(assert (= var3399!1 (str.++ var3399 " - ")))
(assert true)
(define-const var2750 var1088 (get/-1007821573 var3482 "group")) ; Statement: $r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group") 
 ; Statement: if $r32 == null goto $r47 = "" 
(assert (= var2750 null-var1088)) ; Cond: $r32 == null 
(define-const var2291 String "") ; Statement: $r47 = "" 
(assert true) ; Non Conditional
(define-const var1063 Bool (var2755_isNotEmpty/-1251449450 var2291)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47) 
 ; Statement: if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert (= (ite var1063 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var359 var1088 (get/-1007821573 var3482 "service")) ; Statement: $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert true)
;(assert (append/-1031950772 var428!2 var359)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33) 
(declare-const var428!3 String)
(assert (str.prefixof var428!2 var428!3))
(assert true)
(define-const var313 var1088 (get/-1007821573 var3482 "version")) ; Statement: $r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
 ; Statement: if $r34 == null goto $r48 = "" 
(assert (= var313 null-var1088)) ; Cond: $r34 == null 
(define-const var2963 String "") ; Statement: $r48 = "" 
(assert true) ; Non Conditional
(define-const var2770 Bool (var2755_isNotEmpty/-1251449450 var2963)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48) 
 ; Statement: if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(assert (= (ite var2770 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (append/-1166366385 var428!3 32)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var428!4 String)
(assert (str.prefixof var428!3 var428!4))
(assert true)
(define-const var14 var1088 (get/-1007821573 var3482 "method-name")) ; Statement: $r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name") 
(assert true)
;(assert (append/-1031950772 var428!4 var14)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35) 
(declare-const var428!5 String)
(assert (str.prefixof var428!4 var428!5))
(assert true)
;(assert (append/-1166366385 var428!5 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var428!6 String)
(assert (str.prefixof var428!5 var428!6))
(assert true)
(define-const var2509 var1088 (get/-1007821573 var3482 "types")) ; Statement: $r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
 ; Statement: if $r36 == null goto $r49 = newarray (java.lang.Class)[0] 
(assert (not (= var2509 null-var1088))) ; Negate: Cond: $r36 == null  
(assert true)
(define-const var161 var1088 (get/-1007821573 var3482 "types")) ; Statement: $r42 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
(define-const var2231 (Array Int ClassObject) (cast-from-var1088-to-__Array__Int__ClassObject__ var161)) ; Statement: $r49 = (java.lang.Class[]) $r42 
 ; Statement: goto [?= z2 = 1] 
(assert true) ; Non Conditional
(define-const var3730 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(define-const var728 (Array Int ClassObject) var2231) ; Statement: r50 = $r49 
(define-const var2365 Int (getLength-Arr-ClassObject-1 var2231)) ; Statement: $i1 = lengthof $r49 
(define-const var1525 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(assert (>= var1525 var2365)) ; Cond: i2 >= $i1 
(assert true)
;(assert (append/672562846 var428!6 ") ")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var428!7 String)
(assert (= var428!7 (str.++ var428!6 ") ")))
(assert true)
(define-const var1755 var1088 (get/-1007821573 var3482 "arguments")) ; Statement: $r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
 ; Statement: if $r37 == null goto $r51 = null 
(assert (not (= var1755 null-var1088))) ; Negate: Cond: $r37 == null  
(assert true)
(define-const var147 var1088 (get/-1007821573 var3482 "arguments")) ; Statement: $r39 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
(define-const var3812 (Array Int var1088) (cast-from-var1088-to-__Array__Int__var1088__ var147)) ; Statement: $r51 = (java.lang.Object[]) $r39 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var3812 null-__Array__Int__var1088__)) ; Cond: $r51 == null 
(assert true)
(define-const var2759 String (toString/-2075883882 var428!7)) ; Statement: $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r52 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getInvocationTime/675231966=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), toInstant/-822818885=([java.util.Date], java.time.Instant), var2873_systemDefault/1019915793=([], java.time.ZoneId), var3057_ofInstant/129408697=([java.time.Instant, java.time.ZoneId], java.time.LocalDateTime), format/372879155=([java.time.LocalDateTime, java.time.format.DateTimeFormatter], java.lang.String), getOutTime/324948452=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), get/-1007821573=([org.apache.dubbo.rpc.support.AccessLogData, java.lang.String], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var2755_isNotEmpty/-1251449450=([java.lang.String], boolean), cast-from-var1088-to-__Array__Int__ClassObject__=([java.lang.Object], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), cast-from-var1088-to-__Array__Int__var1088__=([java.lang.Object], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2065=org.apache.dubbo.rpc.support.AccessLogData, var3482=r1, var428=$r0, var852=$r8, var3096=java.util.Date, var3998=$r2, var138=java.time.Instant, var3786=$r4, var2873=java.time.ZoneId, var1330=$r3, var3057=java.time.LocalDateTime, var491=$r6, var3074=java.time.format.DateTimeFormatter, var1097=$r5, var1777=$r7, var2245=$r9, var2008=$r10, var802=$r11, var3589=$r18, var3791=$r12, var2675=$r14, var2321=$r13, var1508=$r16, var3567=$r15, var1857=$r17, var1692=$r19, var750=$r21, var1088=java.lang.Object, var1558=$r20, var3743=$r22, var2180=$r24, var1574=$r23, var3300=$r25, var2195=$r27, var1513=$r26, var3520=$r28, var2087=$r30, var1090=$r29, var3399=$r31, var2750=$r32, var2291=$r47, var2755=org.apache.dubbo.common.utils.StringUtils, var1063=$z0, var359=$r33, var313=$r34, var2963=$r48, var2770=$z1, var14=$r35, var2509=$r36, var161=$r42, var2231=$r49, var3730=z2, var728=r50, var2365=$i1, var1525=i2, var1755=$r37, var147=$r39, var3812=$r51, var2759=$r52}
; {org.apache.dubbo.rpc.support.AccessLogData=var2065, r1=var3482, $r0=var428, $r8=var852, java.util.Date=var3096, $r2=var3998, java.time.Instant=var138, $r4=var3786, java.time.ZoneId=var2873, $r3=var1330, java.time.LocalDateTime=var3057, $r6=var491, java.time.format.DateTimeFormatter=var3074, $r5=var1097, $r7=var1777, $r9=var2245, $r10=var2008, $r11=var802, $r18=var3589, $r12=var3791, $r14=var2675, $r13=var2321, $r16=var1508, $r15=var3567, $r17=var1857, $r19=var1692, $r21=var750, java.lang.Object=var1088, $r20=var1558, $r22=var3743, $r24=var2180, $r23=var1574, $r25=var3300, $r27=var2195, $r26=var1513, $r28=var3520, $r30=var2087, $r29=var1090, $r31=var3399, $r32=var2750, $r47=var2291, org.apache.dubbo.common.utils.StringUtils=var2755, $z0=var1063, $r33=var359, $r34=var313, $r48=var2963, $z1=var2770, $r35=var14, $r36=var2509, $r42=var161, $r49=var2231, z2=var3730, r50=var728, $i1=var2365, i2=var1525, $r37=var1755, $r39=var147, $r51=var3812, $r52=var2759}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 4,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.support.AccessLogData;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>();	$r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>();	$r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3);	$r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ");	$r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>();	$r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>();	$r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13);	$r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20);	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23);	$r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost");	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26);	$r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ");	$r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group");	if $r32 == null goto $r47 = "";	$r47 = "";	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47);	if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	$r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33);	$r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	if $r34 == null goto $r48 = "";	$r48 = "";	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48);	if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	if $r36 == null goto $r49 = newarray (java.lang.Class)[0];	$r42 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	$r49 = (java.lang.Class[]) $r42;	goto [?= z2 = 1];	z2 = 1;	r50 = $r49;	$i1 = lengthof $r49;	i2 = 0;	if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	if $r37 == null goto $r51 = null;	$r39 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	$r51 = (java.lang.Object[]) $r39;	goto [?= (branch)];	if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r52
;block_num 14