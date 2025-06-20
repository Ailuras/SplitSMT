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

(declare-sort var1990 0)
(declare-sort var3218 0)
(declare-sort var3414 0)
(declare-sort var2208 0)
(declare-sort var1757 0)
(declare-sort var1555 0)
(declare-sort var1571 0)
(declare-sort var816 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getInvocationTime/675231966 (var1990) var3218)
(declare-fun toInstant/-822818885 (var3218) var3414)
(declare-fun var2208_systemDefault/1019915793 () var2208)
(declare-fun var1757_ofInstant/129408697 (var3414 var2208) var1757)
(declare-fun format/372879155 (var1757 var1555) String)
(declare-fun getOutTime/324948452 (var1990) var3218)
(declare-fun get/-1007821573 (var1990 String) var1571)
(declare-fun append/-1031950772 (String var1571) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var816_isNotEmpty/-1251449450 (String) Bool)
(declare-fun toString/-522406933 (var1571) String)
(declare-fun cast-from-var1571-to-__Array__Int__ClassObject__ (var1571) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1990 var1990)
(declare-const var1990-MESSAGE_DATE_FORMATTER var1555)
(declare-const null-var1571 var1571)
(declare-const null-__Array__Int__var1571__ (Array Int var1571))
(declare-const var3542 var1990) ; Statement: r1 := @this: org.apache.dubbo.rpc.support.AccessLogData 
(assert (not (= var3542 null-var1990)))
(define-const var1662 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1662)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1662!1 String)
(assert (= var1662!1 ""))
(assert true)
(define-const var2541 String (append/672562846 var1662!1 "[")) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var1662!2 String)
(assert (= var1662!2 (str.++ var1662!1 "[")))
(assert true)
(define-const var3477 var3218 (getInvocationTime/675231966 var3542)) ; Statement: $r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>() 
(assert true)
(define-const var3452 var3414 (toInstant/-822818885 var3477)) ; Statement: $r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var3475 var2208 var2208_systemDefault/1019915793) ; Statement: $r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var3982 var1757 (var1757_ofInstant/129408697 var3452 var3475)) ; Statement: $r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3) 
(define-const var1041 var1555 var1990-MESSAGE_DATE_FORMATTER) ; Statement: $r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var1725 String (format/372879155 var3982 var1041)) ; Statement: $r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5) 
(assert true)
(define-const var2681 String (append/672562846 var2541 var1725)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var2541!1 String)
(assert (= var2541!1 (str.++ var2541 var1725)))
(assert true)
(define-const var2636 String (append/672562846 var2681 "] ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var2681!1 String)
(assert (= var2681!1 (str.++ var2681 "] ")))
(assert true)
(define-const var2964 String (append/672562846 var2636 "-> ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ") 
(declare-const var2636!1 String)
(assert (= var2636!1 (str.++ var2636 "-> ")))
(assert true)
(define-const var219 String (append/672562846 var2964 "[")) ; Statement: $r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var2964!1 String)
(assert (= var2964!1 (str.++ var2964 "[")))
(assert true)
(define-const var441 var3218 (getOutTime/324948452 var3542)) ; Statement: $r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>() 
(assert true)
(define-const var1072 var3414 (toInstant/-822818885 var441)) ; Statement: $r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var1242 var2208 var2208_systemDefault/1019915793) ; Statement: $r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var1270 var1757 (var1757_ofInstant/129408697 var1072 var1242)) ; Statement: $r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13) 
(define-const var1423 var1555 var1990-MESSAGE_DATE_FORMATTER) ; Statement: $r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var2415 String (format/372879155 var1270 var1423)) ; Statement: $r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15) 
(assert true)
(define-const var1309 String (append/672562846 var219 var2415)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var219!1 String)
(assert (= var219!1 (str.++ var219 var2415)))
(assert true)
(define-const var1612 String (append/672562846 var1309 "] ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var1309!1 String)
(assert (= var1309!1 (str.++ var1309 "] ")))
(assert true)
(define-const var3428 var1571 (get/-1007821573 var3542 "remote-host")) ; Statement: $r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host") 
(assert true)
(define-const var2863 String (append/-1031950772 var1612 var3428)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20) 
(declare-const var1612!1 String)
(assert (str.prefixof var1612 var1612!1))
(assert true)
(define-const var3500 String (append/-1166366385 var2863 58)) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var2863!1 String)
(assert (str.prefixof var2863 var2863!1))
(assert true)
(define-const var278 var1571 (get/-1007821573 var3542 "remote-port")) ; Statement: $r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port") 
(assert true)
(define-const var12 String (append/-1031950772 var3500 var278)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23) 
(declare-const var3500!1 String)
(assert (str.prefixof var3500 var3500!1))
(assert true)
(define-const var3940 String (append/672562846 var12 " -> ")) ; Statement: $r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var12!1 String)
(assert (= var12!1 (str.++ var12 " -> ")))
(assert true)
(define-const var942 var1571 (get/-1007821573 var3542 "localhost")) ; Statement: $r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost") 
(assert true)
(define-const var1182 String (append/-1031950772 var3940 var942)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26) 
(declare-const var3940!1 String)
(assert (str.prefixof var3940 var3940!1))
(assert true)
(define-const var2594 String (append/-1166366385 var1182 58)) ; Statement: $r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var1182!1 String)
(assert (str.prefixof var1182 var1182!1))
(assert true)
(define-const var2310 var1571 (get/-1007821573 var3542 "local-port")) ; Statement: $r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port") 
(assert true)
(define-const var864 String (append/-1031950772 var2594 var2310)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var2594!1 String)
(assert (str.prefixof var2594 var2594!1))
(assert true)
;(assert (append/672562846 var864 " - ")) ; Statement: virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ") 
(declare-const var864!1 String)
(assert (= var864!1 (str.++ var864 " - ")))
(assert true)
(define-const var1546 var1571 (get/-1007821573 var3542 "group")) ; Statement: $r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group") 
 ; Statement: if $r32 == null goto $r47 = "" 
(assert (= var1546 null-var1571)) ; Cond: $r32 == null 
(define-const var3718 String "") ; Statement: $r47 = "" 
(assert true) ; Non Conditional
(define-const var2195 Bool (var816_isNotEmpty/-1251449450 var3718)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47) 
 ; Statement: if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert (= (ite var2195 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2325 var1571 (get/-1007821573 var3542 "service")) ; Statement: $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert true)
;(assert (append/-1031950772 var1662!2 var2325)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33) 
(declare-const var1662!3 String)
(assert (str.prefixof var1662!2 var1662!3))
(assert true)
(define-const var2611 var1571 (get/-1007821573 var3542 "version")) ; Statement: $r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
 ; Statement: if $r34 == null goto $r48 = "" 
(assert (not (= var2611 null-var1571))) ; Negate: Cond: $r34 == null  
(assert true)
(define-const var1017 var1571 (get/-1007821573 var3542 "version")) ; Statement: $r44 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
(assert true)
(define-const var3460 String (toString/-522406933 var1017)) ; Statement: $r48 = virtualinvoke $r44.<java.lang.Object: java.lang.String toString()>() 
 ; Statement: goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48)] 
(assert true) ; Non Conditional
(define-const var2755 Bool (var816_isNotEmpty/-1251449450 var3460)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48) 
 ; Statement: if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(assert (= (ite var2755 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (append/-1166366385 var1662!3 32)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var1662!4 String)
(assert (str.prefixof var1662!3 var1662!4))
(assert true)
(define-const var3657 var1571 (get/-1007821573 var3542 "method-name")) ; Statement: $r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name") 
(assert true)
;(assert (append/-1031950772 var1662!4 var3657)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35) 
(declare-const var1662!5 String)
(assert (str.prefixof var1662!4 var1662!5))
(assert true)
;(assert (append/-1166366385 var1662!5 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var1662!6 String)
(assert (str.prefixof var1662!5 var1662!6))
(assert true)
(define-const var244 var1571 (get/-1007821573 var3542 "types")) ; Statement: $r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
 ; Statement: if $r36 == null goto $r49 = newarray (java.lang.Class)[0] 
(assert (not (= var244 null-var1571))) ; Negate: Cond: $r36 == null  
(assert true)
(define-const var3182 var1571 (get/-1007821573 var3542 "types")) ; Statement: $r42 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
(define-const var2220 (Array Int ClassObject) (cast-from-var1571-to-__Array__Int__ClassObject__ var3182)) ; Statement: $r49 = (java.lang.Class[]) $r42 
 ; Statement: goto [?= z2 = 1] 
(assert true) ; Non Conditional
(define-const var1992 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(define-const var3203 (Array Int ClassObject) var2220) ; Statement: r50 = $r49 
(define-const var1261 Int (getLength-Arr-ClassObject-1 var2220)) ; Statement: $i1 = lengthof $r49 
(define-const var2090 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(assert (>= var2090 var1261)) ; Cond: i2 >= $i1 
(assert true)
;(assert (append/672562846 var1662!6 ") ")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var1662!7 String)
(assert (= var1662!7 (str.++ var1662!6 ") ")))
(assert true)
(define-const var1846 var1571 (get/-1007821573 var3542 "arguments")) ; Statement: $r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
 ; Statement: if $r37 == null goto $r51 = null 
(assert (= var1846 null-var1571)) ; Cond: $r37 == null 
(define-const var236 (Array Int var1571) null-__Array__Int__var1571__) ; Statement: $r51 = null 
(assert true) ; Non Conditional
 ; Statement: if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var236 null-__Array__Int__var1571__)) ; Cond: $r51 == null 
(assert true)
(define-const var3453 String (toString/-2075883882 var1662!7)) ; Statement: $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r52 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getInvocationTime/675231966=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), toInstant/-822818885=([java.util.Date], java.time.Instant), var2208_systemDefault/1019915793=([], java.time.ZoneId), var1757_ofInstant/129408697=([java.time.Instant, java.time.ZoneId], java.time.LocalDateTime), format/372879155=([java.time.LocalDateTime, java.time.format.DateTimeFormatter], java.lang.String), getOutTime/324948452=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), get/-1007821573=([org.apache.dubbo.rpc.support.AccessLogData, java.lang.String], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var816_isNotEmpty/-1251449450=([java.lang.String], boolean), toString/-522406933=([java.lang.Object], java.lang.String), cast-from-var1571-to-__Array__Int__ClassObject__=([java.lang.Object], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1990=org.apache.dubbo.rpc.support.AccessLogData, var3542=r1, var1662=$r0, var2541=$r8, var3218=java.util.Date, var3477=$r2, var3414=java.time.Instant, var3452=$r4, var2208=java.time.ZoneId, var3475=$r3, var1757=java.time.LocalDateTime, var3982=$r6, var1555=java.time.format.DateTimeFormatter, var1041=$r5, var1725=$r7, var2681=$r9, var2636=$r10, var2964=$r11, var219=$r18, var441=$r12, var1072=$r14, var1242=$r13, var1270=$r16, var1423=$r15, var2415=$r17, var1309=$r19, var1612=$r21, var1571=java.lang.Object, var3428=$r20, var2863=$r22, var3500=$r24, var278=$r23, var12=$r25, var3940=$r27, var942=$r26, var1182=$r28, var2594=$r30, var2310=$r29, var864=$r31, var1546=$r32, var3718=$r47, var816=org.apache.dubbo.common.utils.StringUtils, var2195=$z0, var2325=$r33, var2611=$r34, var1017=$r44, var3460=$r48, var2755=$z1, var3657=$r35, var244=$r36, var3182=$r42, var2220=$r49, var1992=z2, var3203=r50, var1261=$i1, var2090=i2, var1846=$r37, var236=$r51, var3453=$r52}
; {org.apache.dubbo.rpc.support.AccessLogData=var1990, r1=var3542, $r0=var1662, $r8=var2541, java.util.Date=var3218, $r2=var3477, java.time.Instant=var3414, $r4=var3452, java.time.ZoneId=var2208, $r3=var3475, java.time.LocalDateTime=var1757, $r6=var3982, java.time.format.DateTimeFormatter=var1555, $r5=var1041, $r7=var1725, $r9=var2681, $r10=var2636, $r11=var2964, $r18=var219, $r12=var441, $r14=var1072, $r13=var1242, $r16=var1270, $r15=var1423, $r17=var2415, $r19=var1309, $r21=var1612, java.lang.Object=var1571, $r20=var3428, $r22=var2863, $r24=var3500, $r23=var278, $r25=var12, $r27=var3940, $r26=var942, $r28=var1182, $r30=var2594, $r29=var2310, $r31=var864, $r32=var1546, $r47=var3718, org.apache.dubbo.common.utils.StringUtils=var816, $z0=var2195, $r33=var2325, $r34=var2611, $r44=var1017, $r48=var3460, $z1=var2755, $r35=var3657, $r36=var244, $r42=var3182, $r49=var2220, z2=var1992, r50=var3203, $i1=var1261, i2=var2090, $r37=var1846, $r51=var236, $r52=var3453}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.Object: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 4,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.support.AccessLogData;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>();	$r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>();	$r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3);	$r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ");	$r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>();	$r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>();	$r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13);	$r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20);	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23);	$r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost");	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26);	$r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ");	$r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group");	if $r32 == null goto $r47 = "";	$r47 = "";	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47);	if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	$r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33);	$r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	if $r34 == null goto $r48 = "";	$r44 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	$r48 = virtualinvoke $r44.<java.lang.Object: java.lang.String toString()>();	goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48)];	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48);	if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	if $r36 == null goto $r49 = newarray (java.lang.Class)[0];	$r42 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	$r49 = (java.lang.Class[]) $r42;	goto [?= z2 = 1];	z2 = 1;	r50 = $r49;	$i1 = lengthof $r49;	i2 = 0;	if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	if $r37 == null goto $r51 = null;	$r51 = null;	if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r52
;block_num 14