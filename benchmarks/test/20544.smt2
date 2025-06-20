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

(declare-sort var3795 0)
(declare-sort var2735 0)
(declare-sort var1982 0)
(declare-sort var1908 0)
(declare-sort var871 0)
(declare-sort var892 0)
(declare-sort var3948 0)
(declare-sort var2145 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getInvocationTime/675231966 (var3795) var2735)
(declare-fun toInstant/-822818885 (var2735) var1982)
(declare-fun var1908_systemDefault/1019915793 () var1908)
(declare-fun var871_ofInstant/129408697 (var1982 var1908) var871)
(declare-fun format/372879155 (var871 var892) String)
(declare-fun getOutTime/324948452 (var3795) var2735)
(declare-fun get/-1007821573 (var3795 String) var3948)
(declare-fun append/-1031950772 (String var3948) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var2145_isNotEmpty/-1251449450 (String) Bool)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun cast-from-var3948-to-__Array__Int__var3948__ (var3948) (Array Int var3948))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3795 var3795)
(declare-const var3795-MESSAGE_DATE_FORMATTER var892)
(declare-const null-var3948 var3948)
(declare-const null-__Array__Int__var3948__ (Array Int var3948))
(declare-const var3551 var3795) ; Statement: r1 := @this: org.apache.dubbo.rpc.support.AccessLogData 
(assert (not (= var3551 null-var3795)))
(define-const var724 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var724)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var724!1 String)
(assert (= var724!1 ""))
(assert true)
(define-const var3272 String (append/672562846 var724!1 "[")) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var724!2 String)
(assert (= var724!2 (str.++ var724!1 "[")))
(assert true)
(define-const var2978 var2735 (getInvocationTime/675231966 var3551)) ; Statement: $r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>() 
(assert true)
(define-const var3804 var1982 (toInstant/-822818885 var2978)) ; Statement: $r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var2393 var1908 var1908_systemDefault/1019915793) ; Statement: $r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var2971 var871 (var871_ofInstant/129408697 var3804 var2393)) ; Statement: $r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3) 
(define-const var2230 var892 var3795-MESSAGE_DATE_FORMATTER) ; Statement: $r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var196 String (format/372879155 var2971 var2230)) ; Statement: $r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5) 
(assert true)
(define-const var3457 String (append/672562846 var3272 var196)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var3272!1 String)
(assert (= var3272!1 (str.++ var3272 var196)))
(assert true)
(define-const var2809 String (append/672562846 var3457 "] ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var3457!1 String)
(assert (= var3457!1 (str.++ var3457 "] ")))
(assert true)
(define-const var1978 String (append/672562846 var2809 "-> ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ") 
(declare-const var2809!1 String)
(assert (= var2809!1 (str.++ var2809 "-> ")))
(assert true)
(define-const var2355 String (append/672562846 var1978 "[")) ; Statement: $r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var1978!1 String)
(assert (= var1978!1 (str.++ var1978 "[")))
(assert true)
(define-const var3921 var2735 (getOutTime/324948452 var3551)) ; Statement: $r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>() 
(assert true)
(define-const var3909 var1982 (toInstant/-822818885 var3921)) ; Statement: $r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var2098 var1908 var1908_systemDefault/1019915793) ; Statement: $r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var1243 var871 (var871_ofInstant/129408697 var3909 var2098)) ; Statement: $r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13) 
(define-const var581 var892 var3795-MESSAGE_DATE_FORMATTER) ; Statement: $r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var1741 String (format/372879155 var1243 var581)) ; Statement: $r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15) 
(assert true)
(define-const var3101 String (append/672562846 var2355 var1741)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var2355!1 String)
(assert (= var2355!1 (str.++ var2355 var1741)))
(assert true)
(define-const var2561 String (append/672562846 var3101 "] ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var3101!1 String)
(assert (= var3101!1 (str.++ var3101 "] ")))
(assert true)
(define-const var1261 var3948 (get/-1007821573 var3551 "remote-host")) ; Statement: $r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host") 
(assert true)
(define-const var3519 String (append/-1031950772 var2561 var1261)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20) 
(declare-const var2561!1 String)
(assert (str.prefixof var2561 var2561!1))
(assert true)
(define-const var2072 String (append/-1166366385 var3519 58)) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var3519!1 String)
(assert (str.prefixof var3519 var3519!1))
(assert true)
(define-const var2337 var3948 (get/-1007821573 var3551 "remote-port")) ; Statement: $r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port") 
(assert true)
(define-const var327 String (append/-1031950772 var2072 var2337)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23) 
(declare-const var2072!1 String)
(assert (str.prefixof var2072 var2072!1))
(assert true)
(define-const var1391 String (append/672562846 var327 " -> ")) ; Statement: $r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var327!1 String)
(assert (= var327!1 (str.++ var327 " -> ")))
(assert true)
(define-const var1416 var3948 (get/-1007821573 var3551 "localhost")) ; Statement: $r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost") 
(assert true)
(define-const var1367 String (append/-1031950772 var1391 var1416)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26) 
(declare-const var1391!1 String)
(assert (str.prefixof var1391 var1391!1))
(assert true)
(define-const var3207 String (append/-1166366385 var1367 58)) ; Statement: $r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var1367!1 String)
(assert (str.prefixof var1367 var1367!1))
(assert true)
(define-const var1044 var3948 (get/-1007821573 var3551 "local-port")) ; Statement: $r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port") 
(assert true)
(define-const var2394 String (append/-1031950772 var3207 var1044)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var3207!1 String)
(assert (str.prefixof var3207 var3207!1))
(assert true)
;(assert (append/672562846 var2394 " - ")) ; Statement: virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ") 
(declare-const var2394!1 String)
(assert (= var2394!1 (str.++ var2394 " - ")))
(assert true)
(define-const var2296 var3948 (get/-1007821573 var3551 "group")) ; Statement: $r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group") 
 ; Statement: if $r32 == null goto $r47 = "" 
(assert (= var2296 null-var3948)) ; Cond: $r32 == null 
(define-const var3035 String "") ; Statement: $r47 = "" 
(assert true) ; Non Conditional
(define-const var1000 Bool (var2145_isNotEmpty/-1251449450 var3035)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47) 
 ; Statement: if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert (= (ite var1000 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3836 var3948 (get/-1007821573 var3551 "service")) ; Statement: $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert true)
;(assert (append/-1031950772 var724!2 var3836)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33) 
(declare-const var724!3 String)
(assert (str.prefixof var724!2 var724!3))
(assert true)
(define-const var3618 var3948 (get/-1007821573 var3551 "version")) ; Statement: $r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
 ; Statement: if $r34 == null goto $r48 = "" 
(assert (= var3618 null-var3948)) ; Cond: $r34 == null 
(define-const var1345 String "") ; Statement: $r48 = "" 
(assert true) ; Non Conditional
(define-const var1962 Bool (var2145_isNotEmpty/-1251449450 var1345)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48) 
 ; Statement: if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(assert (= (ite var1962 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (append/-1166366385 var724!3 32)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var724!4 String)
(assert (str.prefixof var724!3 var724!4))
(assert true)
(define-const var1987 var3948 (get/-1007821573 var3551 "method-name")) ; Statement: $r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name") 
(assert true)
;(assert (append/-1031950772 var724!4 var1987)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35) 
(declare-const var724!5 String)
(assert (str.prefixof var724!4 var724!5))
(assert true)
;(assert (append/-1166366385 var724!5 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var724!6 String)
(assert (str.prefixof var724!5 var724!6))
(assert true)
(define-const var1529 var3948 (get/-1007821573 var3551 "types")) ; Statement: $r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
 ; Statement: if $r36 == null goto $r49 = newarray (java.lang.Class)[0] 
(assert (= var1529 null-var3948)) ; Cond: $r36 == null 
(define-const var328 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r49 = newarray (java.lang.Class)[0] 
(assert true) ; Non Conditional
(define-const var1225 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(define-const var484 (Array Int ClassObject) var328) ; Statement: r50 = $r49 
(define-const var1142 Int (getLength-Arr-ClassObject-1 var328)) ; Statement: $i1 = lengthof $r49 
(define-const var3650 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(assert (>= var3650 var1142)) ; Cond: i2 >= $i1 
(assert true)
;(assert (append/672562846 var724!6 ") ")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var724!7 String)
(assert (= var724!7 (str.++ var724!6 ") ")))
(assert true)
(define-const var1507 var3948 (get/-1007821573 var3551 "arguments")) ; Statement: $r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
 ; Statement: if $r37 == null goto $r51 = null 
(assert (not (= var1507 null-var3948))) ; Negate: Cond: $r37 == null  
(assert true)
(define-const var2596 var3948 (get/-1007821573 var3551 "arguments")) ; Statement: $r39 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
(define-const var59 (Array Int var3948) (cast-from-var3948-to-__Array__Int__var3948__ var2596)) ; Statement: $r51 = (java.lang.Object[]) $r39 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var59 null-__Array__Int__var3948__)) ; Cond: $r51 == null 
(assert true)
(define-const var1505 String (toString/-2075883882 var724!7)) ; Statement: $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r52 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getInvocationTime/675231966=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), toInstant/-822818885=([java.util.Date], java.time.Instant), var1908_systemDefault/1019915793=([], java.time.ZoneId), var871_ofInstant/129408697=([java.time.Instant, java.time.ZoneId], java.time.LocalDateTime), format/372879155=([java.time.LocalDateTime, java.time.format.DateTimeFormatter], java.lang.String), getOutTime/324948452=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), get/-1007821573=([org.apache.dubbo.rpc.support.AccessLogData, java.lang.String], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var2145_isNotEmpty/-1251449450=([java.lang.String], boolean), arr-ClassObject-init=([], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), cast-from-var3948-to-__Array__Int__var3948__=([java.lang.Object], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3795=org.apache.dubbo.rpc.support.AccessLogData, var3551=r1, var724=$r0, var3272=$r8, var2735=java.util.Date, var2978=$r2, var1982=java.time.Instant, var3804=$r4, var1908=java.time.ZoneId, var2393=$r3, var871=java.time.LocalDateTime, var2971=$r6, var892=java.time.format.DateTimeFormatter, var2230=$r5, var196=$r7, var3457=$r9, var2809=$r10, var1978=$r11, var2355=$r18, var3921=$r12, var3909=$r14, var2098=$r13, var1243=$r16, var581=$r15, var1741=$r17, var3101=$r19, var2561=$r21, var3948=java.lang.Object, var1261=$r20, var3519=$r22, var2072=$r24, var2337=$r23, var327=$r25, var1391=$r27, var1416=$r26, var1367=$r28, var3207=$r30, var1044=$r29, var2394=$r31, var2296=$r32, var3035=$r47, var2145=org.apache.dubbo.common.utils.StringUtils, var1000=$z0, var3836=$r33, var3618=$r34, var1345=$r48, var1962=$z1, var1987=$r35, var1529=$r36, var328=$r49, var1225=z2, var484=r50, var1142=$i1, var3650=i2, var1507=$r37, var2596=$r39, var59=$r51, var1505=$r52}
; {org.apache.dubbo.rpc.support.AccessLogData=var3795, r1=var3551, $r0=var724, $r8=var3272, java.util.Date=var2735, $r2=var2978, java.time.Instant=var1982, $r4=var3804, java.time.ZoneId=var1908, $r3=var2393, java.time.LocalDateTime=var871, $r6=var2971, java.time.format.DateTimeFormatter=var892, $r5=var2230, $r7=var196, $r9=var3457, $r10=var2809, $r11=var1978, $r18=var2355, $r12=var3921, $r14=var3909, $r13=var2098, $r16=var1243, $r15=var581, $r17=var1741, $r19=var3101, $r21=var2561, java.lang.Object=var3948, $r20=var1261, $r22=var3519, $r24=var2072, $r23=var2337, $r25=var327, $r27=var1391, $r26=var1416, $r28=var1367, $r30=var3207, $r29=var1044, $r31=var2394, $r32=var2296, $r47=var3035, org.apache.dubbo.common.utils.StringUtils=var2145, $z0=var1000, $r33=var3836, $r34=var3618, $r48=var1345, $z1=var1962, $r35=var1987, $r36=var1529, $r49=var328, z2=var1225, r50=var484, $i1=var1142, i2=var3650, $r37=var1507, $r39=var2596, $r51=var59, $r52=var1505}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 4,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.support.AccessLogData;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>();	$r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>();	$r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3);	$r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ");	$r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>();	$r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>();	$r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13);	$r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20);	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23);	$r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost");	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26);	$r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ");	$r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group");	if $r32 == null goto $r47 = "";	$r47 = "";	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47);	if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	$r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33);	$r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	if $r34 == null goto $r48 = "";	$r48 = "";	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48);	if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	if $r36 == null goto $r49 = newarray (java.lang.Class)[0];	$r49 = newarray (java.lang.Class)[0];	z2 = 1;	r50 = $r49;	$i1 = lengthof $r49;	i2 = 0;	if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	if $r37 == null goto $r51 = null;	$r39 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	$r51 = (java.lang.Object[]) $r39;	goto [?= (branch)];	if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r52
;block_num 14