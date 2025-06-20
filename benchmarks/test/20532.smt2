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

(declare-sort var1951 0)
(declare-sort var2702 0)
(declare-sort var2107 0)
(declare-sort var1451 0)
(declare-sort var328 0)
(declare-sort var3658 0)
(declare-sort var2718 0)
(declare-sort var168 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getInvocationTime/675231966 (var1951) var2702)
(declare-fun toInstant/-822818885 (var2702) var2107)
(declare-fun var1451_systemDefault/1019915793 () var1451)
(declare-fun var328_ofInstant/129408697 (var2107 var1451) var328)
(declare-fun format/372879155 (var328 var3658) String)
(declare-fun getOutTime/324948452 (var1951) var2702)
(declare-fun get/-1007821573 (var1951 String) var2718)
(declare-fun append/-1031950772 (String var2718) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var168_isNotEmpty/-1251449450 (String) Bool)
(declare-fun cast-from-var2718-to-__Array__Int__ClassObject__ (var2718) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1951 var1951)
(declare-const var1951-MESSAGE_DATE_FORMATTER var3658)
(declare-const null-var2718 var2718)
(declare-const null-__Array__Int__var2718__ (Array Int var2718))
(declare-const var3863 var1951) ; Statement: r1 := @this: org.apache.dubbo.rpc.support.AccessLogData 
(assert (not (= var3863 null-var1951)))
(define-const var801 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var801)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var801!1 String)
(assert (= var801!1 ""))
(assert true)
(define-const var3533 String (append/672562846 var801!1 "[")) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var801!2 String)
(assert (= var801!2 (str.++ var801!1 "[")))
(assert true)
(define-const var1781 var2702 (getInvocationTime/675231966 var3863)) ; Statement: $r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>() 
(assert true)
(define-const var124 var2107 (toInstant/-822818885 var1781)) ; Statement: $r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var2515 var1451 var1451_systemDefault/1019915793) ; Statement: $r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var1284 var328 (var328_ofInstant/129408697 var124 var2515)) ; Statement: $r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3) 
(define-const var3884 var3658 var1951-MESSAGE_DATE_FORMATTER) ; Statement: $r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var3144 String (format/372879155 var1284 var3884)) ; Statement: $r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5) 
(assert true)
(define-const var1074 String (append/672562846 var3533 var3144)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var3533!1 String)
(assert (= var3533!1 (str.++ var3533 var3144)))
(assert true)
(define-const var514 String (append/672562846 var1074 "] ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var1074!1 String)
(assert (= var1074!1 (str.++ var1074 "] ")))
(assert true)
(define-const var37 String (append/672562846 var514 "-> ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ") 
(declare-const var514!1 String)
(assert (= var514!1 (str.++ var514 "-> ")))
(assert true)
(define-const var3303 String (append/672562846 var37 "[")) ; Statement: $r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var37!1 String)
(assert (= var37!1 (str.++ var37 "[")))
(assert true)
(define-const var1011 var2702 (getOutTime/324948452 var3863)) ; Statement: $r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>() 
(assert true)
(define-const var1983 var2107 (toInstant/-822818885 var1011)) ; Statement: $r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var762 var1451 var1451_systemDefault/1019915793) ; Statement: $r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var1520 var328 (var328_ofInstant/129408697 var1983 var762)) ; Statement: $r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13) 
(define-const var1456 var3658 var1951-MESSAGE_DATE_FORMATTER) ; Statement: $r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var3785 String (format/372879155 var1520 var1456)) ; Statement: $r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15) 
(assert true)
(define-const var2032 String (append/672562846 var3303 var3785)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var3303!1 String)
(assert (= var3303!1 (str.++ var3303 var3785)))
(assert true)
(define-const var1840 String (append/672562846 var2032 "] ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var2032!1 String)
(assert (= var2032!1 (str.++ var2032 "] ")))
(assert true)
(define-const var3309 var2718 (get/-1007821573 var3863 "remote-host")) ; Statement: $r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host") 
(assert true)
(define-const var2332 String (append/-1031950772 var1840 var3309)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20) 
(declare-const var1840!1 String)
(assert (str.prefixof var1840 var1840!1))
(assert true)
(define-const var2829 String (append/-1166366385 var2332 58)) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var2332!1 String)
(assert (str.prefixof var2332 var2332!1))
(assert true)
(define-const var2552 var2718 (get/-1007821573 var3863 "remote-port")) ; Statement: $r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port") 
(assert true)
(define-const var180 String (append/-1031950772 var2829 var2552)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23) 
(declare-const var2829!1 String)
(assert (str.prefixof var2829 var2829!1))
(assert true)
(define-const var249 String (append/672562846 var180 " -> ")) ; Statement: $r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var180!1 String)
(assert (= var180!1 (str.++ var180 " -> ")))
(assert true)
(define-const var1591 var2718 (get/-1007821573 var3863 "localhost")) ; Statement: $r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost") 
(assert true)
(define-const var628 String (append/-1031950772 var249 var1591)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26) 
(declare-const var249!1 String)
(assert (str.prefixof var249 var249!1))
(assert true)
(define-const var2294 String (append/-1166366385 var628 58)) ; Statement: $r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var628!1 String)
(assert (str.prefixof var628 var628!1))
(assert true)
(define-const var2571 var2718 (get/-1007821573 var3863 "local-port")) ; Statement: $r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port") 
(assert true)
(define-const var2357 String (append/-1031950772 var2294 var2571)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var2294!1 String)
(assert (str.prefixof var2294 var2294!1))
(assert true)
;(assert (append/672562846 var2357 " - ")) ; Statement: virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ") 
(declare-const var2357!1 String)
(assert (= var2357!1 (str.++ var2357 " - ")))
(assert true)
(define-const var408 var2718 (get/-1007821573 var3863 "group")) ; Statement: $r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group") 
 ; Statement: if $r32 == null goto $r47 = "" 
(assert (= var408 null-var2718)) ; Cond: $r32 == null 
(define-const var548 String "") ; Statement: $r47 = "" 
(assert true) ; Non Conditional
(define-const var3201 Bool (var168_isNotEmpty/-1251449450 var548)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47) 
 ; Statement: if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert (= (ite var3201 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1122 var2718 (get/-1007821573 var3863 "service")) ; Statement: $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert true)
;(assert (append/-1031950772 var801!2 var1122)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33) 
(declare-const var801!3 String)
(assert (str.prefixof var801!2 var801!3))
(assert true)
(define-const var492 var2718 (get/-1007821573 var3863 "version")) ; Statement: $r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
 ; Statement: if $r34 == null goto $r48 = "" 
(assert (= var492 null-var2718)) ; Cond: $r34 == null 
(define-const var1347 String "") ; Statement: $r48 = "" 
(assert true) ; Non Conditional
(define-const var2267 Bool (var168_isNotEmpty/-1251449450 var1347)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48) 
 ; Statement: if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(assert (= (ite var2267 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (append/-1166366385 var801!3 32)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var801!4 String)
(assert (str.prefixof var801!3 var801!4))
(assert true)
(define-const var3945 var2718 (get/-1007821573 var3863 "method-name")) ; Statement: $r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name") 
(assert true)
;(assert (append/-1031950772 var801!4 var3945)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35) 
(declare-const var801!5 String)
(assert (str.prefixof var801!4 var801!5))
(assert true)
;(assert (append/-1166366385 var801!5 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var801!6 String)
(assert (str.prefixof var801!5 var801!6))
(assert true)
(define-const var3814 var2718 (get/-1007821573 var3863 "types")) ; Statement: $r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
 ; Statement: if $r36 == null goto $r49 = newarray (java.lang.Class)[0] 
(assert (not (= var3814 null-var2718))) ; Negate: Cond: $r36 == null  
(assert true)
(define-const var2906 var2718 (get/-1007821573 var3863 "types")) ; Statement: $r42 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
(define-const var2897 (Array Int ClassObject) (cast-from-var2718-to-__Array__Int__ClassObject__ var2906)) ; Statement: $r49 = (java.lang.Class[]) $r42 
 ; Statement: goto [?= z2 = 1] 
(assert true) ; Non Conditional
(define-const var3057 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(define-const var1171 (Array Int ClassObject) var2897) ; Statement: r50 = $r49 
(define-const var2880 Int (getLength-Arr-ClassObject-1 var2897)) ; Statement: $i1 = lengthof $r49 
(define-const var3611 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(assert (>= var3611 var2880)) ; Cond: i2 >= $i1 
(assert true)
;(assert (append/672562846 var801!6 ") ")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var801!7 String)
(assert (= var801!7 (str.++ var801!6 ") ")))
(assert true)
(define-const var1172 var2718 (get/-1007821573 var3863 "arguments")) ; Statement: $r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
 ; Statement: if $r37 == null goto $r51 = null 
(assert (= var1172 null-var2718)) ; Cond: $r37 == null 
(define-const var3894 (Array Int var2718) null-__Array__Int__var2718__) ; Statement: $r51 = null 
(assert true) ; Non Conditional
 ; Statement: if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var3894 null-__Array__Int__var2718__)) ; Cond: $r51 == null 
(assert true)
(define-const var1949 String (toString/-2075883882 var801!7)) ; Statement: $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r52 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getInvocationTime/675231966=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), toInstant/-822818885=([java.util.Date], java.time.Instant), var1451_systemDefault/1019915793=([], java.time.ZoneId), var328_ofInstant/129408697=([java.time.Instant, java.time.ZoneId], java.time.LocalDateTime), format/372879155=([java.time.LocalDateTime, java.time.format.DateTimeFormatter], java.lang.String), getOutTime/324948452=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), get/-1007821573=([org.apache.dubbo.rpc.support.AccessLogData, java.lang.String], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var168_isNotEmpty/-1251449450=([java.lang.String], boolean), cast-from-var2718-to-__Array__Int__ClassObject__=([java.lang.Object], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1951=org.apache.dubbo.rpc.support.AccessLogData, var3863=r1, var801=$r0, var3533=$r8, var2702=java.util.Date, var1781=$r2, var2107=java.time.Instant, var124=$r4, var1451=java.time.ZoneId, var2515=$r3, var328=java.time.LocalDateTime, var1284=$r6, var3658=java.time.format.DateTimeFormatter, var3884=$r5, var3144=$r7, var1074=$r9, var514=$r10, var37=$r11, var3303=$r18, var1011=$r12, var1983=$r14, var762=$r13, var1520=$r16, var1456=$r15, var3785=$r17, var2032=$r19, var1840=$r21, var2718=java.lang.Object, var3309=$r20, var2332=$r22, var2829=$r24, var2552=$r23, var180=$r25, var249=$r27, var1591=$r26, var628=$r28, var2294=$r30, var2571=$r29, var2357=$r31, var408=$r32, var548=$r47, var168=org.apache.dubbo.common.utils.StringUtils, var3201=$z0, var1122=$r33, var492=$r34, var1347=$r48, var2267=$z1, var3945=$r35, var3814=$r36, var2906=$r42, var2897=$r49, var3057=z2, var1171=r50, var2880=$i1, var3611=i2, var1172=$r37, var3894=$r51, var1949=$r52}
; {org.apache.dubbo.rpc.support.AccessLogData=var1951, r1=var3863, $r0=var801, $r8=var3533, java.util.Date=var2702, $r2=var1781, java.time.Instant=var2107, $r4=var124, java.time.ZoneId=var1451, $r3=var2515, java.time.LocalDateTime=var328, $r6=var1284, java.time.format.DateTimeFormatter=var3658, $r5=var3884, $r7=var3144, $r9=var1074, $r10=var514, $r11=var37, $r18=var3303, $r12=var1011, $r14=var1983, $r13=var762, $r16=var1520, $r15=var1456, $r17=var3785, $r19=var2032, $r21=var1840, java.lang.Object=var2718, $r20=var3309, $r22=var2332, $r24=var2829, $r23=var2552, $r25=var180, $r27=var249, $r26=var1591, $r28=var628, $r30=var2294, $r29=var2571, $r31=var2357, $r32=var408, $r47=var548, org.apache.dubbo.common.utils.StringUtils=var168, $z0=var3201, $r33=var1122, $r34=var492, $r48=var1347, $z1=var2267, $r35=var3945, $r36=var3814, $r42=var2906, $r49=var2897, z2=var3057, r50=var1171, $i1=var2880, i2=var3611, $r37=var1172, $r51=var3894, $r52=var1949}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 4,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.support.AccessLogData;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>();	$r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>();	$r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3);	$r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ");	$r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>();	$r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>();	$r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13);	$r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20);	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23);	$r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost");	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26);	$r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ");	$r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group");	if $r32 == null goto $r47 = "";	$r47 = "";	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47);	if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	$r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33);	$r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	if $r34 == null goto $r48 = "";	$r48 = "";	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48);	if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	if $r36 == null goto $r49 = newarray (java.lang.Class)[0];	$r42 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	$r49 = (java.lang.Class[]) $r42;	goto [?= z2 = 1];	z2 = 1;	r50 = $r49;	$i1 = lengthof $r49;	i2 = 0;	if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	if $r37 == null goto $r51 = null;	$r51 = null;	if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r52
;block_num 14