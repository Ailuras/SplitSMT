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

(declare-sort var2212 0)
(declare-sort var3926 0)
(declare-sort var3842 0)
(declare-sort var2996 0)
(declare-sort var1294 0)
(declare-sort var860 0)
(declare-sort var2728 0)
(declare-sort var1311 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getInvocationTime/675231966 (var2212) var3926)
(declare-fun toInstant/-822818885 (var3926) var3842)
(declare-fun var2996_systemDefault/1019915793 () var2996)
(declare-fun var1294_ofInstant/129408697 (var3842 var2996) var1294)
(declare-fun format/372879155 (var1294 var860) String)
(declare-fun getOutTime/324948452 (var2212) var3926)
(declare-fun get/-1007821573 (var2212 String) var2728)
(declare-fun append/-1031950772 (String var2728) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var1311_isNotEmpty/-1251449450 (String) Bool)
(declare-fun toString/-522406933 (var2728) String)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2212 var2212)
(declare-const var2212-MESSAGE_DATE_FORMATTER var860)
(declare-const null-var2728 var2728)
(declare-const null-__Array__Int__var2728__ (Array Int var2728))
(declare-const var1821 var2212) ; Statement: r1 := @this: org.apache.dubbo.rpc.support.AccessLogData 
(assert (not (= var1821 null-var2212)))
(define-const var2644 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2644)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2644!1 String)
(assert (= var2644!1 ""))
(assert true)
(define-const var1632 String (append/672562846 var2644!1 "[")) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var2644!2 String)
(assert (= var2644!2 (str.++ var2644!1 "[")))
(assert true)
(define-const var3959 var3926 (getInvocationTime/675231966 var1821)) ; Statement: $r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>() 
(assert true)
(define-const var3530 var3842 (toInstant/-822818885 var3959)) ; Statement: $r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var477 var2996 var2996_systemDefault/1019915793) ; Statement: $r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var829 var1294 (var1294_ofInstant/129408697 var3530 var477)) ; Statement: $r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3) 
(define-const var2792 var860 var2212-MESSAGE_DATE_FORMATTER) ; Statement: $r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var2913 String (format/372879155 var829 var2792)) ; Statement: $r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5) 
(assert true)
(define-const var2175 String (append/672562846 var1632 var2913)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1632!1 String)
(assert (= var1632!1 (str.++ var1632 var2913)))
(assert true)
(define-const var3287 String (append/672562846 var2175 "] ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var2175!1 String)
(assert (= var2175!1 (str.++ var2175 "] ")))
(assert true)
(define-const var1702 String (append/672562846 var3287 "-> ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ") 
(declare-const var3287!1 String)
(assert (= var3287!1 (str.++ var3287 "-> ")))
(assert true)
(define-const var3255 String (append/672562846 var1702 "[")) ; Statement: $r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var1702!1 String)
(assert (= var1702!1 (str.++ var1702 "[")))
(assert true)
(define-const var3894 var3926 (getOutTime/324948452 var1821)) ; Statement: $r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>() 
(assert true)
(define-const var3387 var3842 (toInstant/-822818885 var3894)) ; Statement: $r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var11 var2996 var2996_systemDefault/1019915793) ; Statement: $r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var1105 var1294 (var1294_ofInstant/129408697 var3387 var11)) ; Statement: $r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13) 
(define-const var2247 var860 var2212-MESSAGE_DATE_FORMATTER) ; Statement: $r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var2803 String (format/372879155 var1105 var2247)) ; Statement: $r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15) 
(assert true)
(define-const var1509 String (append/672562846 var3255 var2803)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var3255!1 String)
(assert (= var3255!1 (str.++ var3255 var2803)))
(assert true)
(define-const var837 String (append/672562846 var1509 "] ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var1509!1 String)
(assert (= var1509!1 (str.++ var1509 "] ")))
(assert true)
(define-const var782 var2728 (get/-1007821573 var1821 "remote-host")) ; Statement: $r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host") 
(assert true)
(define-const var460 String (append/-1031950772 var837 var782)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20) 
(declare-const var837!1 String)
(assert (str.prefixof var837 var837!1))
(assert true)
(define-const var299 String (append/-1166366385 var460 58)) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var460!1 String)
(assert (str.prefixof var460 var460!1))
(assert true)
(define-const var1741 var2728 (get/-1007821573 var1821 "remote-port")) ; Statement: $r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port") 
(assert true)
(define-const var3221 String (append/-1031950772 var299 var1741)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23) 
(declare-const var299!1 String)
(assert (str.prefixof var299 var299!1))
(assert true)
(define-const var3570 String (append/672562846 var3221 " -> ")) ; Statement: $r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var3221!1 String)
(assert (= var3221!1 (str.++ var3221 " -> ")))
(assert true)
(define-const var3424 var2728 (get/-1007821573 var1821 "localhost")) ; Statement: $r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost") 
(assert true)
(define-const var3256 String (append/-1031950772 var3570 var3424)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26) 
(declare-const var3570!1 String)
(assert (str.prefixof var3570 var3570!1))
(assert true)
(define-const var1265 String (append/-1166366385 var3256 58)) ; Statement: $r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var3256!1 String)
(assert (str.prefixof var3256 var3256!1))
(assert true)
(define-const var285 var2728 (get/-1007821573 var1821 "local-port")) ; Statement: $r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port") 
(assert true)
(define-const var332 String (append/-1031950772 var1265 var285)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var1265!1 String)
(assert (str.prefixof var1265 var1265!1))
(assert true)
;(assert (append/672562846 var332 " - ")) ; Statement: virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ") 
(declare-const var332!1 String)
(assert (= var332!1 (str.++ var332 " - ")))
(assert true)
(define-const var2587 var2728 (get/-1007821573 var1821 "group")) ; Statement: $r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group") 
 ; Statement: if $r32 == null goto $r47 = "" 
(assert (= var2587 null-var2728)) ; Cond: $r32 == null 
(define-const var1699 String "") ; Statement: $r47 = "" 
(assert true) ; Non Conditional
(define-const var3381 Bool (var1311_isNotEmpty/-1251449450 var1699)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47) 
 ; Statement: if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert (= (ite var3381 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var992 var2728 (get/-1007821573 var1821 "service")) ; Statement: $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert true)
;(assert (append/-1031950772 var2644!2 var992)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33) 
(declare-const var2644!3 String)
(assert (str.prefixof var2644!2 var2644!3))
(assert true)
(define-const var3083 var2728 (get/-1007821573 var1821 "version")) ; Statement: $r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
 ; Statement: if $r34 == null goto $r48 = "" 
(assert (not (= var3083 null-var2728))) ; Negate: Cond: $r34 == null  
(assert true)
(define-const var1428 var2728 (get/-1007821573 var1821 "version")) ; Statement: $r44 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
(assert true)
(define-const var2433 String (toString/-522406933 var1428)) ; Statement: $r48 = virtualinvoke $r44.<java.lang.Object: java.lang.String toString()>() 
 ; Statement: goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48)] 
(assert true) ; Non Conditional
(define-const var524 Bool (var1311_isNotEmpty/-1251449450 var2433)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48) 
 ; Statement: if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(assert (= (ite var524 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (append/-1166366385 var2644!3 32)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var2644!4 String)
(assert (str.prefixof var2644!3 var2644!4))
(assert true)
(define-const var2498 var2728 (get/-1007821573 var1821 "method-name")) ; Statement: $r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name") 
(assert true)
;(assert (append/-1031950772 var2644!4 var2498)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35) 
(declare-const var2644!5 String)
(assert (str.prefixof var2644!4 var2644!5))
(assert true)
;(assert (append/-1166366385 var2644!5 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var2644!6 String)
(assert (str.prefixof var2644!5 var2644!6))
(assert true)
(define-const var2921 var2728 (get/-1007821573 var1821 "types")) ; Statement: $r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
 ; Statement: if $r36 == null goto $r49 = newarray (java.lang.Class)[0] 
(assert (= var2921 null-var2728)) ; Cond: $r36 == null 
(define-const var2561 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r49 = newarray (java.lang.Class)[0] 
(assert true) ; Non Conditional
(define-const var426 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(define-const var3762 (Array Int ClassObject) var2561) ; Statement: r50 = $r49 
(define-const var398 Int (getLength-Arr-ClassObject-1 var2561)) ; Statement: $i1 = lengthof $r49 
(define-const var463 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(assert (>= var463 var398)) ; Cond: i2 >= $i1 
(assert true)
;(assert (append/672562846 var2644!6 ") ")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var2644!7 String)
(assert (= var2644!7 (str.++ var2644!6 ") ")))
(assert true)
(define-const var2309 var2728 (get/-1007821573 var1821 "arguments")) ; Statement: $r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
 ; Statement: if $r37 == null goto $r51 = null 
(assert (= var2309 null-var2728)) ; Cond: $r37 == null 
(define-const var3087 (Array Int var2728) null-__Array__Int__var2728__) ; Statement: $r51 = null 
(assert true) ; Non Conditional
 ; Statement: if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var3087 null-__Array__Int__var2728__)) ; Cond: $r51 == null 
(assert true)
(define-const var272 String (toString/-2075883882 var2644!7)) ; Statement: $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r52 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getInvocationTime/675231966=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), toInstant/-822818885=([java.util.Date], java.time.Instant), var2996_systemDefault/1019915793=([], java.time.ZoneId), var1294_ofInstant/129408697=([java.time.Instant, java.time.ZoneId], java.time.LocalDateTime), format/372879155=([java.time.LocalDateTime, java.time.format.DateTimeFormatter], java.lang.String), getOutTime/324948452=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), get/-1007821573=([org.apache.dubbo.rpc.support.AccessLogData, java.lang.String], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var1311_isNotEmpty/-1251449450=([java.lang.String], boolean), toString/-522406933=([java.lang.Object], java.lang.String), arr-ClassObject-init=([], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2212=org.apache.dubbo.rpc.support.AccessLogData, var1821=r1, var2644=$r0, var1632=$r8, var3926=java.util.Date, var3959=$r2, var3842=java.time.Instant, var3530=$r4, var2996=java.time.ZoneId, var477=$r3, var1294=java.time.LocalDateTime, var829=$r6, var860=java.time.format.DateTimeFormatter, var2792=$r5, var2913=$r7, var2175=$r9, var3287=$r10, var1702=$r11, var3255=$r18, var3894=$r12, var3387=$r14, var11=$r13, var1105=$r16, var2247=$r15, var2803=$r17, var1509=$r19, var837=$r21, var2728=java.lang.Object, var782=$r20, var460=$r22, var299=$r24, var1741=$r23, var3221=$r25, var3570=$r27, var3424=$r26, var3256=$r28, var1265=$r30, var285=$r29, var332=$r31, var2587=$r32, var1699=$r47, var1311=org.apache.dubbo.common.utils.StringUtils, var3381=$z0, var992=$r33, var3083=$r34, var1428=$r44, var2433=$r48, var524=$z1, var2498=$r35, var2921=$r36, var2561=$r49, var426=z2, var3762=r50, var398=$i1, var463=i2, var2309=$r37, var3087=$r51, var272=$r52}
; {org.apache.dubbo.rpc.support.AccessLogData=var2212, r1=var1821, $r0=var2644, $r8=var1632, java.util.Date=var3926, $r2=var3959, java.time.Instant=var3842, $r4=var3530, java.time.ZoneId=var2996, $r3=var477, java.time.LocalDateTime=var1294, $r6=var829, java.time.format.DateTimeFormatter=var860, $r5=var2792, $r7=var2913, $r9=var2175, $r10=var3287, $r11=var1702, $r18=var3255, $r12=var3894, $r14=var3387, $r13=var11, $r16=var1105, $r15=var2247, $r17=var2803, $r19=var1509, $r21=var837, java.lang.Object=var2728, $r20=var782, $r22=var460, $r24=var299, $r23=var1741, $r25=var3221, $r27=var3570, $r26=var3424, $r28=var3256, $r30=var1265, $r29=var285, $r31=var332, $r32=var2587, $r47=var1699, org.apache.dubbo.common.utils.StringUtils=var1311, $z0=var3381, $r33=var992, $r34=var3083, $r44=var1428, $r48=var2433, $z1=var524, $r35=var2498, $r36=var2921, $r49=var2561, z2=var426, r50=var3762, $i1=var398, i2=var463, $r37=var2309, $r51=var3087, $r52=var272}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.Object: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 4,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.support.AccessLogData;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>();	$r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>();	$r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3);	$r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ");	$r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>();	$r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>();	$r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13);	$r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20);	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23);	$r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost");	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26);	$r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ");	$r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group");	if $r32 == null goto $r47 = "";	$r47 = "";	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47);	if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	$r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33);	$r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	if $r34 == null goto $r48 = "";	$r44 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	$r48 = virtualinvoke $r44.<java.lang.Object: java.lang.String toString()>();	goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48)];	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48);	if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	if $r36 == null goto $r49 = newarray (java.lang.Class)[0];	$r49 = newarray (java.lang.Class)[0];	z2 = 1;	r50 = $r49;	$i1 = lengthof $r49;	i2 = 0;	if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	if $r37 == null goto $r51 = null;	$r51 = null;	if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r52
;block_num 14