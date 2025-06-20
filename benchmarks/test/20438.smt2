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

(declare-sort var1559 0)
(declare-sort var1411 0)
(declare-sort var505 0)
(declare-sort var2495 0)
(declare-sort var2040 0)
(declare-sort var2436 0)
(declare-sort var135 0)
(declare-sort var1435 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getInvocationTime/675231966 (var1559) var1411)
(declare-fun toInstant/-822818885 (var1411) var505)
(declare-fun var2495_systemDefault/1019915793 () var2495)
(declare-fun var2040_ofInstant/129408697 (var505 var2495) var2040)
(declare-fun format/372879155 (var2040 var2436) String)
(declare-fun getOutTime/324948452 (var1559) var1411)
(declare-fun get/-1007821573 (var1559 String) var135)
(declare-fun append/-1031950772 (String var135) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun toString/-522406933 (var135) String)
(declare-fun var1435_isNotEmpty/-1251449450 (String) Bool)
(declare-fun cast-from-var135-to-__Array__Int__ClassObject__ (var135) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1559 var1559)
(declare-const var1559-MESSAGE_DATE_FORMATTER var2436)
(declare-const null-var135 var135)
(declare-const null-__Array__Int__var135__ (Array Int var135))
(declare-const var568 var1559) ; Statement: r1 := @this: org.apache.dubbo.rpc.support.AccessLogData 
(assert (not (= var568 null-var1559)))
(define-const var2424 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2424)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2424!1 String)
(assert (= var2424!1 ""))
(assert true)
(define-const var3930 String (append/672562846 var2424!1 "[")) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var2424!2 String)
(assert (= var2424!2 (str.++ var2424!1 "[")))
(assert true)
(define-const var1113 var1411 (getInvocationTime/675231966 var568)) ; Statement: $r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>() 
(assert true)
(define-const var2893 var505 (toInstant/-822818885 var1113)) ; Statement: $r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var2825 var2495 var2495_systemDefault/1019915793) ; Statement: $r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var3914 var2040 (var2040_ofInstant/129408697 var2893 var2825)) ; Statement: $r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3) 
(define-const var2677 var2436 var1559-MESSAGE_DATE_FORMATTER) ; Statement: $r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var2864 String (format/372879155 var3914 var2677)) ; Statement: $r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5) 
(assert true)
(define-const var692 String (append/672562846 var3930 var2864)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var3930!1 String)
(assert (= var3930!1 (str.++ var3930 var2864)))
(assert true)
(define-const var2972 String (append/672562846 var692 "] ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var692!1 String)
(assert (= var692!1 (str.++ var692 "] ")))
(assert true)
(define-const var3548 String (append/672562846 var2972 "-> ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ") 
(declare-const var2972!1 String)
(assert (= var2972!1 (str.++ var2972 "-> ")))
(assert true)
(define-const var3538 String (append/672562846 var3548 "[")) ; Statement: $r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var3548!1 String)
(assert (= var3548!1 (str.++ var3548 "[")))
(assert true)
(define-const var3373 var1411 (getOutTime/324948452 var568)) ; Statement: $r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>() 
(assert true)
(define-const var2508 var505 (toInstant/-822818885 var3373)) ; Statement: $r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var3438 var2495 var2495_systemDefault/1019915793) ; Statement: $r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var3420 var2040 (var2040_ofInstant/129408697 var2508 var3438)) ; Statement: $r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13) 
(define-const var3347 var2436 var1559-MESSAGE_DATE_FORMATTER) ; Statement: $r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var3147 String (format/372879155 var3420 var3347)) ; Statement: $r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15) 
(assert true)
(define-const var1637 String (append/672562846 var3538 var3147)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var3538!1 String)
(assert (= var3538!1 (str.++ var3538 var3147)))
(assert true)
(define-const var2625 String (append/672562846 var1637 "] ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var1637!1 String)
(assert (= var1637!1 (str.++ var1637 "] ")))
(assert true)
(define-const var2859 var135 (get/-1007821573 var568 "remote-host")) ; Statement: $r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host") 
(assert true)
(define-const var773 String (append/-1031950772 var2625 var2859)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20) 
(declare-const var2625!1 String)
(assert (str.prefixof var2625 var2625!1))
(assert true)
(define-const var1904 String (append/-1166366385 var773 58)) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var773!1 String)
(assert (str.prefixof var773 var773!1))
(assert true)
(define-const var838 var135 (get/-1007821573 var568 "remote-port")) ; Statement: $r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port") 
(assert true)
(define-const var3770 String (append/-1031950772 var1904 var838)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23) 
(declare-const var1904!1 String)
(assert (str.prefixof var1904 var1904!1))
(assert true)
(define-const var3549 String (append/672562846 var3770 " -> ")) ; Statement: $r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var3770!1 String)
(assert (= var3770!1 (str.++ var3770 " -> ")))
(assert true)
(define-const var2370 var135 (get/-1007821573 var568 "localhost")) ; Statement: $r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost") 
(assert true)
(define-const var633 String (append/-1031950772 var3549 var2370)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26) 
(declare-const var3549!1 String)
(assert (str.prefixof var3549 var3549!1))
(assert true)
(define-const var3942 String (append/-1166366385 var633 58)) ; Statement: $r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var633!1 String)
(assert (str.prefixof var633 var633!1))
(assert true)
(define-const var98 var135 (get/-1007821573 var568 "local-port")) ; Statement: $r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port") 
(assert true)
(define-const var932 String (append/-1031950772 var3942 var98)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var3942!1 String)
(assert (str.prefixof var3942 var3942!1))
(assert true)
;(assert (append/672562846 var932 " - ")) ; Statement: virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ") 
(declare-const var932!1 String)
(assert (= var932!1 (str.++ var932 " - ")))
(assert true)
(define-const var1925 var135 (get/-1007821573 var568 "group")) ; Statement: $r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group") 
 ; Statement: if $r32 == null goto $r47 = "" 
(assert (not (= var1925 null-var135))) ; Negate: Cond: $r32 == null  
(assert true)
(define-const var561 var135 (get/-1007821573 var568 "group")) ; Statement: $r46 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group") 
(assert true)
(define-const var41 String (toString/-522406933 var561)) ; Statement: $r47 = virtualinvoke $r46.<java.lang.Object: java.lang.String toString()>() 
 ; Statement: goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47)] 
(assert true) ; Non Conditional
(define-const var2018 Bool (var1435_isNotEmpty/-1251449450 var41)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47) 
 ; Statement: if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert (= (ite var2018 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1091 var135 (get/-1007821573 var568 "service")) ; Statement: $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert true)
;(assert (append/-1031950772 var2424!2 var1091)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33) 
(declare-const var2424!3 String)
(assert (str.prefixof var2424!2 var2424!3))
(assert true)
(define-const var2660 var135 (get/-1007821573 var568 "version")) ; Statement: $r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
 ; Statement: if $r34 == null goto $r48 = "" 
(assert (= var2660 null-var135)) ; Cond: $r34 == null 
(define-const var3682 String "") ; Statement: $r48 = "" 
(assert true) ; Non Conditional
(define-const var2557 Bool (var1435_isNotEmpty/-1251449450 var3682)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48) 
 ; Statement: if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(assert (= (ite var2557 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (append/-1166366385 var2424!3 32)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var2424!4 String)
(assert (str.prefixof var2424!3 var2424!4))
(assert true)
(define-const var3780 var135 (get/-1007821573 var568 "method-name")) ; Statement: $r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name") 
(assert true)
;(assert (append/-1031950772 var2424!4 var3780)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35) 
(declare-const var2424!5 String)
(assert (str.prefixof var2424!4 var2424!5))
(assert true)
;(assert (append/-1166366385 var2424!5 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var2424!6 String)
(assert (str.prefixof var2424!5 var2424!6))
(assert true)
(define-const var3047 var135 (get/-1007821573 var568 "types")) ; Statement: $r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
 ; Statement: if $r36 == null goto $r49 = newarray (java.lang.Class)[0] 
(assert (not (= var3047 null-var135))) ; Negate: Cond: $r36 == null  
(assert true)
(define-const var905 var135 (get/-1007821573 var568 "types")) ; Statement: $r42 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
(define-const var470 (Array Int ClassObject) (cast-from-var135-to-__Array__Int__ClassObject__ var905)) ; Statement: $r49 = (java.lang.Class[]) $r42 
 ; Statement: goto [?= z2 = 1] 
(assert true) ; Non Conditional
(define-const var1749 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(define-const var1651 (Array Int ClassObject) var470) ; Statement: r50 = $r49 
(define-const var2687 Int (getLength-Arr-ClassObject-1 var470)) ; Statement: $i1 = lengthof $r49 
(define-const var1811 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(assert (>= var1811 var2687)) ; Cond: i2 >= $i1 
(assert true)
;(assert (append/672562846 var2424!6 ") ")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var2424!7 String)
(assert (= var2424!7 (str.++ var2424!6 ") ")))
(assert true)
(define-const var1999 var135 (get/-1007821573 var568 "arguments")) ; Statement: $r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
 ; Statement: if $r37 == null goto $r51 = null 
(assert (= var1999 null-var135)) ; Cond: $r37 == null 
(define-const var3323 (Array Int var135) null-__Array__Int__var135__) ; Statement: $r51 = null 
(assert true) ; Non Conditional
 ; Statement: if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var3323 null-__Array__Int__var135__)) ; Cond: $r51 == null 
(assert true)
(define-const var974 String (toString/-2075883882 var2424!7)) ; Statement: $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r52 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getInvocationTime/675231966=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), toInstant/-822818885=([java.util.Date], java.time.Instant), var2495_systemDefault/1019915793=([], java.time.ZoneId), var2040_ofInstant/129408697=([java.time.Instant, java.time.ZoneId], java.time.LocalDateTime), format/372879155=([java.time.LocalDateTime, java.time.format.DateTimeFormatter], java.lang.String), getOutTime/324948452=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), get/-1007821573=([org.apache.dubbo.rpc.support.AccessLogData, java.lang.String], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-522406933=([java.lang.Object], java.lang.String), var1435_isNotEmpty/-1251449450=([java.lang.String], boolean), cast-from-var135-to-__Array__Int__ClassObject__=([java.lang.Object], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1559=org.apache.dubbo.rpc.support.AccessLogData, var568=r1, var2424=$r0, var3930=$r8, var1411=java.util.Date, var1113=$r2, var505=java.time.Instant, var2893=$r4, var2495=java.time.ZoneId, var2825=$r3, var2040=java.time.LocalDateTime, var3914=$r6, var2436=java.time.format.DateTimeFormatter, var2677=$r5, var2864=$r7, var692=$r9, var2972=$r10, var3548=$r11, var3538=$r18, var3373=$r12, var2508=$r14, var3438=$r13, var3420=$r16, var3347=$r15, var3147=$r17, var1637=$r19, var2625=$r21, var135=java.lang.Object, var2859=$r20, var773=$r22, var1904=$r24, var838=$r23, var3770=$r25, var3549=$r27, var2370=$r26, var633=$r28, var3942=$r30, var98=$r29, var932=$r31, var1925=$r32, var561=$r46, var41=$r47, var1435=org.apache.dubbo.common.utils.StringUtils, var2018=$z0, var1091=$r33, var2660=$r34, var3682=$r48, var2557=$z1, var3780=$r35, var3047=$r36, var905=$r42, var470=$r49, var1749=z2, var1651=r50, var2687=$i1, var1811=i2, var1999=$r37, var3323=$r51, var974=$r52}
; {org.apache.dubbo.rpc.support.AccessLogData=var1559, r1=var568, $r0=var2424, $r8=var3930, java.util.Date=var1411, $r2=var1113, java.time.Instant=var505, $r4=var2893, java.time.ZoneId=var2495, $r3=var2825, java.time.LocalDateTime=var2040, $r6=var3914, java.time.format.DateTimeFormatter=var2436, $r5=var2677, $r7=var2864, $r9=var692, $r10=var2972, $r11=var3548, $r18=var3538, $r12=var3373, $r14=var2508, $r13=var3438, $r16=var3420, $r15=var3347, $r17=var3147, $r19=var1637, $r21=var2625, java.lang.Object=var135, $r20=var2859, $r22=var773, $r24=var1904, $r23=var838, $r25=var3770, $r27=var3549, $r26=var2370, $r28=var633, $r30=var3942, $r29=var98, $r31=var932, $r32=var1925, $r46=var561, $r47=var41, org.apache.dubbo.common.utils.StringUtils=var1435, $z0=var2018, $r33=var1091, $r34=var2660, $r48=var3682, $z1=var2557, $r35=var3780, $r36=var3047, $r42=var905, $r49=var470, z2=var1749, r50=var1651, $i1=var2687, i2=var1811, $r37=var1999, $r51=var3323, $r52=var974}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 4,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.support.AccessLogData;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>();	$r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>();	$r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3);	$r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ");	$r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>();	$r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>();	$r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13);	$r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20);	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23);	$r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost");	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26);	$r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ");	$r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group");	if $r32 == null goto $r47 = "";	$r46 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group");	$r47 = virtualinvoke $r46.<java.lang.Object: java.lang.String toString()>();	goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47)];	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47);	if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	$r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33);	$r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	if $r34 == null goto $r48 = "";	$r48 = "";	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48);	if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	if $r36 == null goto $r49 = newarray (java.lang.Class)[0];	$r42 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	$r49 = (java.lang.Class[]) $r42;	goto [?= z2 = 1];	z2 = 1;	r50 = $r49;	$i1 = lengthof $r49;	i2 = 0;	if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	if $r37 == null goto $r51 = null;	$r51 = null;	if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r52
;block_num 14